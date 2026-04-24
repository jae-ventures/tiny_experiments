import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/pact/domain/models/slot_state.dart';
import '../providers/dashboard_providers.dart';

// ── Visual constants ──────────────────────────────────────────────────────────

const double _kSlotDotDiameter = 56.0;
const double _kBacklogDotDiameter = 18.0;

// Color for empty (unfilled) slot dots.
const Color _kEmptySlotColor = AppColors.onSurfaceDim;

// ── Animation constants (from spec §3.4) ─────────────────────────────────────

// Slot dot drift — slowest of all dots.
const double _kSlotDotSpeed = 14.0; // logical pixels / second
const double _kSlotDotTurnRate = 0.22; // radians / second base rate

// Backlog dot drift — faster and more restless than slot dots.
// ignore: unused_element
const double _kBacklogDotSpeed = 32.0;
// ignore: unused_element
const double _kBacklogDotTurnRate = 0.65;

// Slot dots: slow pulse, scale 1.0 → 1.08, ~3 s loop (spec §3.4).
const double _kSlotPulsePeriod = 3.0; // seconds
const double _kSlotPulseMin = 1.0;
const double _kSlotPulseMax = 1.08;

// Backlog dots: flickering opacity (spec §3.4).
const double _kBacklogFlickerPeriod = 1.8; // seconds
const double _kBacklogOpacityMin = 0.45;
const double _kBacklogOpacityMax = 0.85;

// Edge repulsion — dots curve back inward when within this distance of a border.
const double _kEdgeMargin = 72.0;
const double _kEdgeRepulsion = 52.0;

// Freeze settle period after long-press release (spec §3.4).
const Duration _kSettleDuration = Duration(milliseconds: 1500);

// ── Domain types ──────────────────────────────────────────────────────────────

enum _DotType { emptySlot, activeSlot, backlog }

class _DotInfo {
  final String id;
  final _DotType type;
  final Color color;
  final int? slotIndex;
  final String? pactId;
  final String? backlogId;
  Offset position;
  double angle; // current drift direction in radians
  final double speed;
  final double turnRate;
  final double phaseOffset; // desynchronises pulse / flicker per dot

  _DotInfo({
    required this.id,
    required this.type,
    required this.color,
    required this.position,
    required this.angle,
    required this.speed,
    required this.turnRate,
    required this.phaseOffset,
    this.slotIndex,
    this.pactId, // ignore: unused_element_parameter
    this.backlogId, // ignore: unused_element_parameter
  });

  void update(double dt, Size bounds) {
    // Gradually rotate drift direction.
    angle += turnRate * dt;

    // Base velocity from current direction.
    double vx = math.cos(angle) * speed;
    double vy = math.sin(angle) * speed;

    // Soft edge repulsion — dots curve back inward, never escape the space.
    final rx = bounds.width - _kEdgeMargin;
    final ry = bounds.height - _kEdgeMargin;
    if (position.dx < _kEdgeMargin) {
      vx += _kEdgeRepulsion * (1 - position.dx / _kEdgeMargin);
    } else if (position.dx > rx) {
      vx -= _kEdgeRepulsion * (1 - (bounds.width - position.dx) / _kEdgeMargin);
    }
    if (position.dy < _kEdgeMargin) {
      vy += _kEdgeRepulsion * (1 - position.dy / _kEdgeMargin);
    } else if (position.dy > ry) {
      vy -= _kEdgeRepulsion * (1 - (bounds.height - position.dy) / _kEdgeMargin);
    }

    position = Offset(
      (position.dx + vx * dt).clamp(16.0, bounds.width - 16.0),
      (position.dy + vy * dt).clamp(16.0, bounds.height - 16.0),
    );
  }
}

// ── Public widget ─────────────────────────────────────────────────────────────

/// Upper region of the dashboard (~55% of screen height).
///
/// Displays animated slot dots (large) and backlog dots (small) scattered
/// organically across an open canvas. Slot dots represent earned PACT capacity;
/// backlog dots represent captured ideas not yet activated.
///
/// Spec refs: 03_ui_spec_dashboard.md §3
class PossibilitySpace extends ConsumerWidget {
  const PossibilitySpace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotStateAsync = ref.watch(slotStateProvider);

    // Show a sensible default while the async load resolves (typically instant).
    const defaultState = SlotState(
      totalSlots: 1,
      usedSlots: 0,
      completedPactCount: 0,
      pactsUntilNextSlot: 3,
    );

    final slotState = slotStateAsync.when(
      data: (s) => s,
      loading: () => defaultState,
      error: (err, _) => defaultState,
    );

    return _PossibilitySpaceCanvas(slotState: slotState);
  }
}

// ── Animated canvas ───────────────────────────────────────────────────────────

class _PossibilitySpaceCanvas extends StatefulWidget {
  final SlotState slotState;

  const _PossibilitySpaceCanvas({required this.slotState});

  @override
  State<_PossibilitySpaceCanvas> createState() => _PossibilitySpaceCanvasState();
}

class _PossibilitySpaceCanvasState extends State<_PossibilitySpaceCanvas>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  // Advances every frame regardless of freeze — drives pulse / flicker.
  double _animSeconds = 0.0;

  bool _frozen = false;

  final List<_DotInfo> _dots = [];
  final _random = math.Random();
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void didUpdateWidget(_PossibilitySpaceCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slotState != widget.slotState && _size != Size.zero) {
      _reconcileDots(widget.slotState);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  // ── Ticker ──────────────────────────────────────────────────────────────

  void _onTick(Duration elapsed) {
    // Skip first frame — no previous timestamp yet.
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }

    final dt = (elapsed - _lastElapsed).inMicroseconds / 1e6;
    _lastElapsed = elapsed;

    // Guard against stale frames (e.g., after coming back from background).
    if (dt <= 0 || dt > 0.1) return;

    _animSeconds += dt;

    if (!_frozen) {
      for (final dot in _dots) {
        dot.update(dt, _size);
      }
    }

    setState(() {});
  }

  // ── Dot management ───────────────────────────────────────────────────────

  void _initDots(Size size) {
    _size = size;
    _dots.clear();
    _buildSlotDots(widget.slotState, <_DotInfo>[]);
    // Backlog dots wired in Epic 6 — see _reconcileDots for the stub comment.
  }

  /// Reconciles the dot list when slot state changes, preserving existing
  /// dot positions so the canvas doesn't visually reset.
  ///
  /// TODO (Epic 3): extend to carry PACT id → slot index mapping so active
  /// slot dots show the correct PACT color from the assigned palette entry.
  void _reconcileDots(SlotState slotState) {
    final existingSlot = _dots
        .where((d) => d.type == _DotType.emptySlot || d.type == _DotType.activeSlot)
        .toList();
    final existingBacklog =
        _dots.where((d) => d.type == _DotType.backlog).toList();

    _dots.clear();
    _buildSlotDots(slotState, existingSlot);

    // Backlog dots (spec §3.3): small, desaturated, dim, slow drift, flickering
    // opacity — represent captured ideas not yet active. Wired up in Epic 6
    // (lib/features/backlog). Until then, this list is always empty.
    _dots.addAll(existingBacklog);

    if (mounted) setState(() {});
  }

  void _buildSlotDots(SlotState slotState, List<_DotInfo> existing) {
    for (int i = 0; i < slotState.totalSlots; i++) {
      final isActive = i < slotState.usedSlots;
      final color = isActive
          ? AppColors.pactPalette[i % AppColors.pactPalette.length]
          : _kEmptySlotColor;
      final prev = i < existing.length ? existing[i] : null;

      _dots.add(_DotInfo(
        id: 'slot_$i',
        type: isActive ? _DotType.activeSlot : _DotType.emptySlot,
        color: color,
        slotIndex: i,
        // pactId populated in Epic 3 when PACT → slot assignment exists.
        position: prev?.position ?? _randomPosition(_kSlotDotDiameter),
        angle: prev?.angle ?? (_random.nextDouble() * 2 * math.pi),
        speed: _kSlotDotSpeed,
        // Add ±20 % variation so each dot's rhythm feels independent.
        turnRate: _kSlotDotTurnRate * (0.8 + _random.nextDouble() * 0.4),
        phaseOffset: prev?.phaseOffset ?? (_random.nextDouble() * _kSlotPulsePeriod),
      ));
    }
  }

  Offset _randomPosition(double dotDiameter) {
    if (_size == Size.zero) return const Offset(80, 80);
    final pad = dotDiameter + _kEdgeMargin * 0.5;
    return Offset(
      pad + _random.nextDouble() * (_size.width - pad * 2),
      pad + _random.nextDouble() * (_size.height - pad * 2),
    );
  }

  // ── Gesture handlers ─────────────────────────────────────────────────────

  void _freeze() => setState(() => _frozen = true);

  void _unfreeze() {
    // Brief settle period before dots resume drifting (spec §3.4).
    Future.delayed(_kSettleDuration, () {
      if (mounted) setState(() => _frozen = false);
    });
  }

  void _handleBackgroundTap(BuildContext context) {
    if (widget.slotState.hasAvailableSlot) {
      context.push(AppRoutes.pactCreate);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'All ${widget.slotState.totalSlots} PACT slots are active. '
            'Complete one to unlock more.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleDotTap(_DotInfo dot, BuildContext context) {
    switch (dot.type) {
      case _DotType.emptySlot:
        context.push(AppRoutes.pactCreate);
      case _DotType.activeSlot:
        if (dot.pactId != null) {
          context.push(AppRoutes.pactDetailPath(dot.pactId!));
        }
      case _DotType.backlog:
        // TODO (Epic 6): navigate to backlog item detail screen.
        // Spec ref: 03_ui_spec_dashboard.md §3.3
        break;
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // TODO: respect MediaQuery.of(context).disableAnimations for reduceMotion
    // accessibility — replace drift/pulse with static positions (spec §3.4).

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        // Initialise dots once we know the canvas dimensions.
        if (_size == Size.zero && size != Size.zero) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _initDots(size));
          });
        } else if (_size != size && size != Size.zero) {
          _size = size;
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: (_) => _freeze(),
          onLongPressEnd: (_) => _unfreeze(),
          onTap: () => _handleBackgroundTap(context),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              for (final dot in _dots) _buildDot(dot, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDot(_DotInfo dot, BuildContext context) {
    final isSlot = dot.type != _DotType.backlog;
    final diameter = isSlot ? _kSlotDotDiameter : _kBacklogDotDiameter;

    // Compute animated scale for slot dots (pulse).
    double scale = 1.0;
    if (isSlot) {
      final t = (_animSeconds + dot.phaseOffset) % _kSlotPulsePeriod;
      final pulse = math.sin(t / _kSlotPulsePeriod * 2 * math.pi);
      scale = _lerp(_kSlotPulseMin, _kSlotPulseMax, (pulse + 1) / 2);
    }

    // Compute animated opacity for backlog dots (flicker).
    double opacity = 1.0;
    if (dot.type == _DotType.backlog) {
      final t = (_animSeconds + dot.phaseOffset) % _kBacklogFlickerPeriod;
      final flicker = math.sin(t / _kBacklogFlickerPeriod * 2 * math.pi);
      opacity = _lerp(_kBacklogOpacityMin, _kBacklogOpacityMax, (flicker + 1) / 2);
    }

    return Positioned(
      left: dot.position.dx - diameter / 2,
      top: dot.position.dy - diameter / 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _handleDotTap(dot, context),
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: _DotVisual(
              diameter: diameter,
              color: dot.color,
              type: dot.type,
            ),
          ),
        ),
      ),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}

// ── Dot visual ────────────────────────────────────────────────────────────────

class _DotVisual extends StatelessWidget {
  final double diameter;
  final Color color;
  final _DotType type;

  const _DotVisual({
    required this.diameter,
    required this.color,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = type == _DotType.emptySlot;
    final isActive = type == _DotType.activeSlot;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Empty slot: transparent fill with a dim border ring.
        // Active slot: vivid filled circle.
        // Backlog: semi-transparent small circle, no glow.
        color: isEmpty ? Colors.transparent : color.withValues(alpha: isActive ? 0.85 : 0.55),
        border: isEmpty
            ? Border.all(color: color.withValues(alpha: 0.5), width: 1.5)
            : null,
        boxShadow: (isEmpty || isActive)
            ? [
                BoxShadow(
                  color: color.withValues(alpha: isEmpty ? 0.18 : 0.40),
                  blurRadius: isEmpty ? 14 : 22,
                  spreadRadius: isEmpty ? 3 : 5,
                ),
              ]
            : null,
      ),
    );
  }
}
