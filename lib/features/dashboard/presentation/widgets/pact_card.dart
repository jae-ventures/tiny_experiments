import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/pact/domain/models/pact.dart';
import '../../../../features/tracking/domain/models/trial.dart';
import '../../../../features/tracking/domain/use_cases/log_trial_use_case.dart';
import '../../../../features/tracking/domain/use_cases/save_informal_reflection_use_case.dart';
import '../providers/dashboard_providers.dart';

// ── Check-in state helpers ────────────────────────────────────────────────────

enum _CheckInState { pending, done, notDue }

DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

/// Derives the check-in button state from the current trial list.
///
/// Priority:
///   1. Already logged (completed or late) today → done
///   2. Actionable pending trial (today or overdue) → pending
///   3. Nothing due → notDue
_CheckInState _deriveCheckInState(List<Trial> trials) {
  final today = _dateOnly(DateTime.now());

  final loggedToday = trials.any(
    (t) =>
        (t.status == TrialStatus.completed || t.status == TrialStatus.late) &&
        t.completedAt != null &&
        _dateOnly(t.completedAt!) == today,
  );
  if (loggedToday) return _CheckInState.done;

  final hasActionable = trials.any(
    (t) =>
        t.status == TrialStatus.pending &&
        !_dateOnly(t.scheduledDate).isAfter(today),
  );
  return hasActionable ? _CheckInState.pending : _CheckInState.notDue;
}

/// Returns the most-recent actionable pending trial (today or overdue).
Trial? _actionableTrial(List<Trial> trials) {
  final today = _dateOnly(DateTime.now());
  final actionable = trials
      .where(
        (t) =>
            t.status == TrialStatus.pending &&
            !_dateOnly(t.scheduledDate).isAfter(today),
      )
      .toList()
    ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));
  return actionable.isEmpty ? null : actionable.first;
}

// ── Public card widget ────────────────────────────────────────────────────────

/// One PACT card in the carousel.
///
/// Shows: header (PACT name + color dot), a progress chart (trial grid),
/// the check-in button, and the reflection footer with temperature selector
/// and quick-note field.
///
/// [slotIndex] determines the color from [AppColors.pactPalette] and must be
/// consistent with the slot dot displayed in PossibilitySpace above.
///
/// Spec refs: 03_ui_spec_dashboard.md §4.2
class PactCard extends ConsumerWidget {
  final Pact pact;
  final int slotIndex;

  const PactCard({super.key, required this.pact, required this.slotIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trials = ref.watch(trialsForPactProvider(pact.id)).asData?.value ?? [];
    final color = AppColors.pactPalette[slotIndex % AppColors.pactPalette.length];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 2),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(pact: pact, color: color),
            const Divider(height: 1, thickness: 1, color: AppColors.outlineVariant),
            Expanded(
              child: _CardBody(pact: pact, color: color, trials: trials),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.outlineVariant),
            _ReflectionFooter(pact: pact, trials: trials, color: color),
          ],
        ),
      ),
    );
  }
}

// ── Card header ───────────────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  final Pact pact;
  final Color color;

  const _CardHeader({required this.pact, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _commitmentSentence(pact),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onBackground,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // Color dot — tapping navigates to PACT detail.
          // Spec §4.2: "small colored dot matching the slot dot in the
          // possibility space above — creates visual continuity between zones."
          GestureDetector(
            onTap: () => context.push(AppRoutes.pactDetailPath(pact.id)),
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.40),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card body ─────────────────────────────────────────────────────────────────

class _CardBody extends StatelessWidget {
  final Pact pact;
  final Color color;
  final List<Trial> trials;

  const _CardBody({
    required this.pact,
    required this.color,
    required this.trials,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Progress chart — tapping navigates to PACT detail.
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => context.push(AppRoutes.pactDetailPath(pact.id)),
              child: _ProgressChart(color: color, trials: trials),
            ),
          ),
          const SizedBox(width: 16),
          // Check-in button — the primary daily action.
          _CheckInButton(pact: pact, color: color, trials: trials),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ── Sentence helper ───────────────────────────────────────────────────────────

/// Mirrors PactFormState.commitmentSentence but derives from the stored Pact.
/// Day-of-week is read from [pact.startDate] for non-daily cadences.
String _commitmentSentence(Pact pact) {
  final cadenceInterval = switch (pact.cadence) {
    PactCadence.daily => 1,
    PactCadence.weekly => 7,
    PactCadence.biweekly => 14,
    PactCadence.monthly => 30,
  };
  final totalDays = pact.durationTrials * cadenceInterval;
  final durationLabel = _formatDays(totalDays);
  final dowName = DateFormat('EEEE').format(pact.startDate);
  final cadencePhrase = switch (pact.cadence) {
    PactCadence.daily => 'every day',
    PactCadence.weekly => 'every $dowName',
    PactCadence.biweekly => 'every other $dowName',
    PactCadence.monthly => 'every month',
  };
  return 'I will ${pact.action} $cadencePhrase for $durationLabel';
}

String _formatDays(int days) {
  if (days <= 0) return '';
  if (days < 7) return '$days ${days == 1 ? 'day' : 'days'}';
  if (days < 30) {
    final w = days ~/ 7, r = days % 7;
    final s = '$w ${w == 1 ? 'week' : 'weeks'}';
    return r == 0 ? s : '$s and $r ${r == 1 ? 'day' : 'days'}';
  }
  if (days < 365) {
    final m = days ~/ 30, r = days % 30;
    final s = '$m ${m == 1 ? 'month' : 'months'}';
    return r == 0 ? s : '$s and $r ${r == 1 ? 'day' : 'days'}';
  }
  final y = days ~/ 365, rm = (days % 365) ~/ 30;
  final s = '$y ${y == 1 ? 'year' : 'years'}';
  return rm == 0 ? s : '$s and $rm ${rm == 1 ? 'month' : 'months'}';
}

// ── Progress chart ────────────────────────────────────────────────────────────

/// Trial progress chart — dots arranged in a 5-column grid inside an outlined
/// container.
///
/// The container is the future home of free-flowing animated dots (Epic 3+).
/// For now the static grid makes the "filling up toward completion" metaphor
/// immediately legible. Ghost dots pad the last row so the grid feels like a
/// fixed-size box.
///
/// Status → visual:
///   - Completed  → solid PACT color
///   - Late       → PACT color at 65% opacity
///   - Skipped    → muted gray square
///   - Pending due/overdue → outlined, PACT color border
///   - Pending future → very faint
///
/// Spec ref: 03_ui_spec_dashboard.md §4.2 (Progress Chart)
class _ProgressChart extends StatelessWidget {
  final Color color;
  final List<Trial> trials;

  static const _cols = 5;
  static const _dotSize = 10.0;
  static const _dotGap = 4.0;

  const _ProgressChart({required this.color, required this.trials});

  @override
  Widget build(BuildContext context) {
    if (trials.isEmpty) {
      return Text(
        'Generating schedule…',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceDim,
            ),
      );
    }

    final sorted = List<Trial>.from(trials)
      ..sort((a, b) => a.sequenceIndex.compareTo(b.sequenceIndex));

    final total = sorted.length;
    final rows = (total / _cols).ceil();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1),
        color: color.withValues(alpha: 0.04),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(rows, (row) {
          return Padding(
            padding: EdgeInsets.only(top: row > 0 ? _dotGap : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_cols, (col) {
                final idx = row * _cols + col;
                return Padding(
                  padding: EdgeInsets.only(left: col > 0 ? _dotGap : 0),
                  child: idx < total
                      ? _TrialDot(trial: sorted[idx], pactColor: color)
                      : _GhostDot(color: color),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

class _TrialDot extends StatelessWidget {
  final Trial trial;
  final Color pactColor;

  const _TrialDot({required this.trial, required this.pactColor});

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final scheduled = _dateOnly(trial.scheduledDate);

    final (Color fill, Color stroke) = switch (trial.status) {
      TrialStatus.completed => (pactColor, pactColor),
      TrialStatus.late => (pactColor.withValues(alpha: 0.65), pactColor),
      TrialStatus.skipped => (
          AppColors.onSurfaceDim.withValues(alpha: 0.25),
          AppColors.onSurfaceDim.withValues(alpha: 0.5),
        ),
      TrialStatus.pending => scheduled.isAfter(today)
          ? (
              pactColor.withValues(alpha: 0.07),
              pactColor.withValues(alpha: 0.18),
            )
          : (Colors.transparent, pactColor.withValues(alpha: 0.7)),
    };

    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill,
        border: Border.all(color: stroke, width: 1.5),
      ),
    );
  }
}

/// Ghost dot — fills empty grid cells so the box always has a fixed shape.
class _GhostDot extends StatelessWidget {
  final Color color;
  const _GhostDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ProgressChart._dotSize,
      height: _ProgressChart._dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.04),
        border: Border.all(color: color.withValues(alpha: 0.08), width: 1),
      ),
    );
  }
}

// ── Check-in button ───────────────────────────────────────────────────────────

/// The primary action affordance of the app — a large circle button on the
/// right side of each card.
///
/// States (spec §4.2):
///   - pending  → muted surface, PACT-color border, gray checkmark, tappable
///   - done     → muted surface, no border, green checkmark, not tappable
///   - notDue   → muted surface, no border, dim checkmark, not tappable
///
/// Using a checkmark in all states (not a plus) reinforces that the user is
/// checking off a recurring commitment, not creating something new.
///
/// Tapping logs the most-recent actionable trial via [LogTrialUseCase].
/// The [trialsForPactProvider] stream then auto-refreshes, updating the button.
class _CheckInButton extends ConsumerStatefulWidget {
  final Pact pact;
  final Color color;
  final List<Trial> trials;

  const _CheckInButton({
    required this.pact,
    required this.color,
    required this.trials,
  });

  @override
  ConsumerState<_CheckInButton> createState() => _CheckInButtonState();
}

class _CheckInButtonState extends ConsumerState<_CheckInButton> {
  bool _loading = false;

  Future<void> _handleTap() async {
    final trial = _actionableTrial(widget.trials);
    if (trial == null || _loading) return;

    setState(() => _loading = true);

    final result = await ref.read(logTrialUseCaseProvider).execute(trial.id);

    if (!mounted) return;
    setState(() => _loading = false);

    result.fold(
      (Failure f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(f.message),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      (_) => null, // trialsForPactProvider stream auto-updates the UI
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _deriveCheckInState(widget.trials);
    const size = 64.0;

    // pending: outlined circle (transparent fill + full PACT-color border) —
    //          reads as an empty checkbox ready to be checked off.
    // done:    filled surface + green checkmark — confirms the log landed.
    // notDue:  filled surface + dim checkmark — nothing actionable right now.
    final (Color bg, Color fg, Border? border, List<BoxShadow>? shadow) =
        switch (state) {
      _CheckInState.pending => (
          Colors.transparent,
          widget.color,
          Border.all(color: widget.color, width: 2),
          [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.25),
              blurRadius: 12,
              spreadRadius: 1,
            )
          ],
        ),
      _CheckInState.done => (
          AppColors.success.withValues(alpha: 0.15),
          AppColors.success,
          null,
          [
            BoxShadow(
              color: AppColors.success.withValues(alpha: 0.18),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
      _CheckInState.notDue => (
          AppColors.surfaceVariant,
          AppColors.onSurfaceDim,
          null,
          null,
        ),
    };

    return GestureDetector(
      onTap: state == _CheckInState.pending ? _handleTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          border: border,
          boxShadow: shadow,
        ),
        child: Center(
          child: _loading
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: fg,
                  ),
                )
              : Icon(
                  Icons.check_rounded,
                  color: fg,
                  size: 30,
                ),
        ),
      ),
    );
  }
}

// ── Reflection footer ─────────────────────────────────────────────────────────

/// Always-visible footer strip for informal reflections.
///
/// Contains:
///   1. Curiosity temperature selector (cold ❄ / warm ~ / fiery 🔥)
///   2. Quick-note text field with template hint (+ · - · →)
///   3. Save button — appears only when there is something to save
///
/// On save: calls [SaveInformalReflectionUseCase] and resets local state.
/// Saving is always optional — the footer is never hidden or locked.
///
/// The note is stored as a Reflection.note. If the user also sets temperature,
/// both fields are combined into a single Reflection entry.
///
/// Spec refs: 03_ui_spec_dashboard.md §4.2 (Reflection Footer)
class _ReflectionFooter extends ConsumerStatefulWidget {
  final Pact pact;
  final List<Trial> trials;
  final Color color;

  const _ReflectionFooter({
    required this.pact,
    required this.trials,
    required this.color,
  });

  @override
  ConsumerState<_ReflectionFooter> createState() => _ReflectionFooterState();
}

class _ReflectionFooterState extends ConsumerState<_ReflectionFooter> {
  CuriosityTemperature? _selectedTemp;
  final _noteController = TextEditingController();
  bool _saving = false;

  bool get _hasInput =>
      _selectedTemp != null || _noteController.text.trim().isNotEmpty;

  /// Session number derived from current trials — mirrors the active run.
  int get _sessionNumber {
    if (widget.trials.isEmpty) return 1;
    return widget.trials.map((t) => t.sessionNumber).reduce(math.max);
  }

  Future<void> _save() async {
    if (!_hasInput || _saving) return;

    setState(() => _saving = true);

    final noteText = _noteController.text.trim();
    final result =
        await ref.read(saveInformalReflectionUseCaseProvider).execute(
              pactId: widget.pact.id,
              sessionNumber: _sessionNumber,
              temperature: _selectedTemp,
              note: noteText.isEmpty ? null : noteText,
            );

    if (!mounted) return;

    result.fold(
      (Failure f) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(f.message),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      (_) => setState(() {
        _saving = false;
        _selectedTemp = null;
        _noteController.clear();
      }),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // ── Temperature selector ──────────────────────────────────────────
          _TempChip(
            icon: Icons.ac_unit_rounded,
            value: CuriosityTemperature.cold,
            selected: _selectedTemp == CuriosityTemperature.cold,
            activeColor: widget.color,
            onTap: () => setState(() {
              _selectedTemp = _selectedTemp == CuriosityTemperature.cold
                  ? null
                  : CuriosityTemperature.cold;
            }),
          ),
          const SizedBox(width: 4),
          _TempChip(
            icon: Icons.waves_rounded,
            value: CuriosityTemperature.warm,
            selected: _selectedTemp == CuriosityTemperature.warm,
            activeColor: widget.color,
            onTap: () => setState(() {
              _selectedTemp = _selectedTemp == CuriosityTemperature.warm
                  ? null
                  : CuriosityTemperature.warm;
            }),
          ),
          const SizedBox(width: 4),
          _TempChip(
            icon: Icons.local_fire_department_rounded,
            value: CuriosityTemperature.fiery,
            selected: _selectedTemp == CuriosityTemperature.fiery,
            activeColor: widget.color,
            onTap: () => setState(() {
              _selectedTemp = _selectedTemp == CuriosityTemperature.fiery
                  ? null
                  : CuriosityTemperature.fiery;
            }),
          ),
          const SizedBox(width: 8),
          // ── Quick-note field ──────────────────────────────────────────────
          Expanded(
            child: TextField(
              controller: _noteController,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onBackground,
                  ),
              decoration: InputDecoration(
                hintText: '+ working  − stuck  → try',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceDim,
                    ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _save(),
              textInputAction: TextInputAction.done,
            ),
          ),
          // ── Save trigger (visible when there is something to save) ────────
          if (_hasInput) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _save,
              child: _saving
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: widget.color,
                      ),
                    )
                  : Icon(
                      Icons.check_circle_outline_rounded,
                      color: widget.color,
                      size: 22,
                    ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Temperature chip ──────────────────────────────────────────────────────────

class _TempChip extends StatelessWidget {
  final IconData icon;
  final CuriosityTemperature value;
  final bool selected;
  final Color activeColor;
  final VoidCallback onTap;

  const _TempChip({
    required this.icon,
    required this.value,
    required this.selected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              selected ? activeColor.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(
            color: selected ? activeColor : AppColors.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 14,
          color: selected ? activeColor : AppColors.onSurfaceDim,
        ),
      ),
    );
  }
}
