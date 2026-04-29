import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/error/failure.dart';
import '../../../core/theme/app_colors.dart';
import '../../dashboard/presentation/providers/dashboard_providers.dart';
import '../../tracking/domain/models/trial.dart';
import '../../tracking/domain/models/trial_metrics.dart';
import '../../tracking/domain/use_cases/get_trial_metrics_use_case.dart';
import '../../tracking/domain/use_cases/save_informal_reflection_use_case.dart';
import '../domain/models/pact.dart';
import 'providers/pact_detail_providers.dart';

// ── Display helpers ───────────────────────────────────────────────────────────
//
// These mirror the equivalent helpers in pact_card.dart. A future refactor can
// consolidate them into a shared presentation utility file.

DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

/// Produces "I will [action] [cadencePhrase] for [durationLabel]".
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

String _cadenceLabel(PactCadence cadence) => switch (cadence) {
      PactCadence.daily => 'Daily',
      PactCadence.weekly => 'Weekly',
      PactCadence.biweekly => 'Bi-weekly',
      PactCadence.monthly => 'Monthly',
    };

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

String _tempLabel(CuriosityTemperature temp) => switch (temp) {
      CuriosityTemperature.cold => 'Cold curiosity',
      CuriosityTemperature.warm => 'Warm curiosity',
      CuriosityTemperature.fiery => 'Fiery curiosity',
    };

IconData _tempIcon(CuriosityTemperature temp) => switch (temp) {
      CuriosityTemperature.cold => Icons.ac_unit_rounded,
      CuriosityTemperature.warm => Icons.waves_rounded,
      CuriosityTemperature.fiery => Icons.local_fire_department_rounded,
    };

// ── Entry point ───────────────────────────────────────────────────────────────

/// Full read-only detail view for a single PACT.
///
/// Shows: summary card (commitment, dates, optional hypothesis/if-then/temp),
/// a date-connected trial progress chart with status counters, and an always-
/// open informal reflection footer.
///
/// The route is already wired in [AppRouter] as `/pact/:id`.
/// Spec ref: 02_feature_spec_pact.md §12
class PactDetailScreen extends ConsumerWidget {
  final String pactId;

  const PactDetailScreen({super.key, required this.pactId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pactAsync = ref.watch(pactDetailProvider(pactId));
    final trials = ref.watch(trialsForPactProvider(pactId)).asData?.value ?? [];
    final slotIndex = ref.watch(pactSlotIndexProvider(pactId));
    final color = AppColors.pactPalette[slotIndex % AppColors.pactPalette.length];

    return pactAsync.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: color),
        ),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.onBackground,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Could not load experiment.\n${e.toString()}',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.onSurface),
            ),
          ),
        ),
      ),
      data: (pact) {
        if (pact == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.onBackground,
            ),
            body: const Center(
              child: Text(
                'Experiment not found.',
                style: TextStyle(color: AppColors.onSurface),
              ),
            ),
          );
        }
        return _DetailScaffold(pact: pact, trials: trials, color: color);
      },
    );
  }
}

// ── Scaffold ──────────────────────────────────────────────────────────────────

class _DetailScaffold extends StatelessWidget {
  final Pact pact;
  final List<Trial> trials;
  final Color color;

  const _DetailScaffold({
    required this.pact,
    required this.trials,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _DetailSliverAppBar(pact: pact, color: color),
          SliverToBoxAdapter(
            child: _SummarySection(pact: pact, color: color),
          ),
          SliverToBoxAdapter(
            child: _ProgressSection(pact: pact, trials: trials, color: color),
          ),
          SliverToBoxAdapter(
            child: _DetailReflectionSection(pact: pact, trials: trials, color: color),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ],
      ),
    );
  }
}

// ── App bar ───────────────────────────────────────────────────────────────────

class _DetailSliverAppBar extends StatelessWidget {
  final Pact pact;
  final Color color;

  const _DetailSliverAppBar({required this.pact, required this.color});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.surface,
      // PACT-color back arrow creates visual link to the slot dot.
      leading: BackButton(color: color),
      title: Text(
        'Experiment',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.onBackground,
              fontWeight: FontWeight.w600,
            ),
      ),
      // Thin accent line anchors the app bar to the PACT's color identity.
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          color: color.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}

// ── Summary section ───────────────────────────────────────────────────────────

/// Commitment summary: sentence, date range, and optional metadata.
///
/// Visual design: a surface-colored card with a thick left accent bar in the
/// PACT's color — reads as a "pull quote" style, emphasizing commitment.
class _SummarySection extends StatelessWidget {
  final Pact pact;
  final Color color;

  const _SummarySection({required this.pact, required this.color});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd();
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent bar
              Container(width: 4, color: color),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Commitment sentence — the hero text
                      Text(
                        _commitmentSentence(pact),
                        style: tt.titleLarge?.copyWith(
                          color: AppColors.onBackground,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Cadence · N trials
                      Row(
                        children: [
                          _MetaChip(
                            label:
                                '${_cadenceLabel(pact.cadence)} · ${pact.durationTrials} trials',
                            color: color,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Date range
                      Text(
                        '${dateFormat.format(pact.startDate)} → ${dateFormat.format(pact.endDate)}',
                        style: tt.bodySmall?.copyWith(
                          color: AppColors.onSurfaceDim,
                        ),
                      ),

                      // Temperature (if set)
                      if (pact.temperature != null) ...[
                        const SizedBox(height: 12),
                        const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.outlineVariant),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              _tempIcon(pact.temperature!),
                              size: 14,
                              color: color.withValues(alpha: 0.85),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _tempLabel(pact.temperature!),
                              style: tt.bodySmall?.copyWith(
                                color: color.withValues(alpha: 0.85),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Hypothesis (if set)
                      if (pact.hypothesis != null &&
                          pact.hypothesis!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.outlineVariant),
                        const SizedBox(height: 12),
                        Text(
                          'Hypothesis',
                          style: tt.labelSmall?.copyWith(
                            color: AppColors.onSurfaceDim,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pact.hypothesis!,
                          style: tt.bodyMedium?.copyWith(
                            color: AppColors.onSurface,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ],

                      // If/Then (if both set)
                      if (pact.ifCondition != null &&
                          pact.thenAction != null) ...[
                        const SizedBox(height: 12),
                        const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.outlineVariant),
                        const SizedBox(height: 12),
                        Text(
                          'Implementation Intention',
                          style: tt.labelSmall?.copyWith(
                            color: AppColors.onSurfaceDim,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _IfThenBlock(
                          ifCondition: pact.ifCondition!,
                          thenAction: pact.thenAction!,
                          color: color,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small pill chip — used for cadence · trials label.
class _MetaChip extends StatelessWidget {
  final String label;
  final Color color;

  const _MetaChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

/// IF … / THEN … display block for implementation intentions.
class _IfThenBlock extends StatelessWidget {
  final String ifCondition;
  final String thenAction;
  final Color color;

  const _IfThenBlock({
    required this.ifCondition,
    required this.thenAction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final labelStyle = tt.labelSmall?.copyWith(
      color: color.withValues(alpha: 0.7),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    );
    final textStyle = tt.bodySmall?.copyWith(
      color: AppColors.onSurface,
      height: 1.4,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IF  ', style: labelStyle),
            Expanded(child: Text(ifCondition, style: textStyle)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('THEN', style: labelStyle),
            const SizedBox(width: 4),
            Expanded(child: Text(thenAction, style: textStyle)),
          ],
        ),
      ],
    );
  }
}

// ── Progress section ──────────────────────────────────────────────────────────

/// Trial progress chart + status counters.
///
/// For daily PACTs: 7-column calendar grid aligned to day-of-week, with
/// abbreviated day headers (M T W T F S S) and day-of-month labels under dots.
///
/// For weekly / biweekly / monthly: sequential 4-column grid with "Apr 27"
/// date labels under each dot.
///
/// Spec ref: 02_feature_spec_pact.md §12.3
class _ProgressSection extends StatelessWidget {
  final Pact pact;
  final List<Trial> trials;
  final Color color;

  const _ProgressSection({
    required this.pact,
    required this.trials,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    // Compute metrics inline using the existing use case.
    final metrics = trials.isEmpty
        ? null
        : GetTrialMetricsUseCase().execute(trials, expectedEndDate: pact.endDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Text(
              'Progress',
              style: tt.labelSmall?.copyWith(
                color: AppColors.onSurfaceDim,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),

            // Chart
            if (trials.isEmpty)
              Text(
                'Generating schedule…',
                style: tt.bodySmall?.copyWith(color: AppColors.onSurfaceDim),
              )
            else
              _DetailTrialChart(pact: pact, trials: trials, color: color),

            // Counters
            if (metrics != null) ...[
              const SizedBox(height: 16),
              const Divider(
                  height: 1, thickness: 1, color: AppColors.outlineVariant),
              const SizedBox(height: 12),
              _CounterRow(metrics: metrics, color: color),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Trial chart ───────────────────────────────────────────────────────────────

class _DetailTrialChart extends StatelessWidget {
  final Pact pact;
  final List<Trial> trials;
  final Color color;

  const _DetailTrialChart({
    required this.pact,
    required this.trials,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = List<Trial>.from(trials)
      ..sort((a, b) => a.sequenceIndex.compareTo(b.sequenceIndex));

    if (pact.cadence == PactCadence.daily) {
      return _CalendarGrid(trials: sorted, color: color);
    }
    return _SequentialGrid(trials: sorted, color: color);
  }
}

// ── Calendar grid (daily PACTs) ───────────────────────────────────────────────

/// 7-column calendar grid aligned to Mon–Sun.
///
/// Empty cells are rendered before the PACT's first trial (if it doesn't start
/// on a Monday) and after the last trial (to complete the final week row).
/// This mirrors how a physical planner page looks — intuitive at a glance.
class _CalendarGrid extends StatelessWidget {
  final List<Trial> trials;
  final Color color;

  static const _dayHeaders = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  const _CalendarGrid({required this.trials, required this.color});

  @override
  Widget build(BuildContext context) {
    // Build a date → trial lookup map.
    final byDate = <DateTime, Trial>{};
    for (final t in trials) {
      byDate[_dateOnly(t.scheduledDate)] = t;
    }

    final startDay = _dateOnly(trials.first.scheduledDate);
    final endDay = _dateOnly(trials.last.scheduledDate);

    // Snap to the Monday that starts the first calendar week.
    // weekday: Mon=1 … Sun=7, so subtract (weekday - 1) to get Monday.
    final calendarStart =
        startDay.subtract(Duration(days: startDay.weekday - 1));

    // Snap to the Sunday that ends the last calendar week.
    final daysToSunday = 7 - endDay.weekday;
    final calendarEnd = endDay.add(Duration(days: daysToSunday));

    final numWeeks =
        calendarEnd.difference(calendarStart).inDays ~/ 7 + 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Day-of-week headers
        Row(
          children: List.generate(7, (i) {
            return Expanded(
              child: Center(
                child: Text(
                  _dayHeaders[i],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceDim,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),

        // Week rows
        ...List.generate(numWeeks, (week) {
          return Padding(
            padding: EdgeInsets.only(top: week > 0 ? 4 : 0),
            child: Row(
              children: List.generate(7, (dow) {
                final date =
                    calendarStart.add(Duration(days: week * 7 + dow));
                final isInRange =
                    !date.isBefore(startDay) && !date.isAfter(endDay);
                final trial = byDate[date];

                return Expanded(
                  child: isInRange && trial != null
                      ? _DetailTrialCell.calendar(
                          trial: trial,
                          color: color,
                          date: date,
                        )
                      : const _EmptyCell(),
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}

// ── Sequential grid (non-daily PACTs) ────────────────────────────────────────

/// 4-column sequential grid for weekly / biweekly / monthly PACTs.
///
/// Each cell shows the dot above a short date label ("Apr 27").
class _SequentialGrid extends StatelessWidget {
  final List<Trial> trials;
  final Color color;

  static const _cols = 4;

  const _SequentialGrid({required this.trials, required this.color});

  @override
  Widget build(BuildContext context) {
    final total = trials.length;
    final rows = (total / _cols).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(rows, (row) {
        return Padding(
          padding: EdgeInsets.only(top: row > 0 ? 6 : 0),
          child: Row(
            children: List.generate(_cols, (col) {
              final idx = row * _cols + col;
              return Expanded(
                child: idx < total
                    ? _DetailTrialCell.sequential(
                        trial: trials[idx],
                        color: color,
                      )
                    : const _EmptyCell(),
              );
            }),
          ),
        );
      }),
    );
  }
}

// ── Individual trial cell ─────────────────────────────────────────────────────

/// A single trial cell: 28×28 px dot above a date label.
///
/// Uses named constructors to distinguish calendar (day-number label: "27") and
/// sequential (abbreviated month-day label: "Apr 27") layouts.
class _DetailTrialCell extends StatelessWidget {
  final Trial trial;
  final Color color;
  final String dateLabel;

  const _DetailTrialCell._({
    required this.trial,
    required this.color,
    required this.dateLabel,
  });

  factory _DetailTrialCell.calendar({
    required Trial trial,
    required Color color,
    required DateTime date,
  }) {
    return _DetailTrialCell._(
      trial: trial,
      color: color,
      dateLabel: DateFormat('d').format(date), // e.g. "27"
    );
  }

  factory _DetailTrialCell.sequential({
    required Trial trial,
    required Color color,
  }) {
    return _DetailTrialCell._(
      trial: trial,
      color: color,
      dateLabel: DateFormat('MMM d').format(trial.scheduledDate), // e.g. "Apr 27"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: _DetailDot(trial: trial, pactColor: color)),
        const SizedBox(height: 3),
        Text(
          dateLabel,
          style: const TextStyle(
            fontSize: 9,
            color: AppColors.onSurfaceDim,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}

/// Transparent placeholder so the grid stays aligned when there is no trial
/// for a given date slot (e.g., before PACT start in the calendar view).
class _EmptyCell extends StatelessWidget {
  const _EmptyCell();

  static const _dotSize = 28.0;

  @override
  Widget build(BuildContext context) {
    // Same height as _DetailTrialCell so rows stay visually consistent.
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: _dotSize, height: _dotSize),
        SizedBox(height: 3),
        SizedBox(height: 11), // label placeholder height
      ],
    );
  }
}

// ── Detail dot ────────────────────────────────────────────────────────────────

/// 28×28 trial dot — same status-to-visual mapping as the card's 10px dots,
/// scaled up for accessibility and date annotation.
///
/// Status visual language (spec §12.3):
///   Completed  → solid PACT color
///   Late       → PACT color at 65% opacity
///   Skipped    → muted gray/amber square (diamond-ish via borderRadius)
///   Pending due/overdue → outline-only, PACT color stroke
///   Pending future      → very faint outline
class _DetailDot extends StatelessWidget {
  final Trial trial;
  final Color pactColor;

  static const _size = 28.0;

  const _DetailDot({required this.trial, required this.pactColor});

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final scheduled = _dateOnly(trial.scheduledDate);

    final bool isSkipped = trial.status == TrialStatus.skipped;

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

    // Skipped trials use a rounded-square to visually distinguish "off" state.
    final borderRadius = isSkipped
        ? BorderRadius.circular(4)
        : BorderRadius.circular(_size / 2);

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: fill,
        border: Border.all(color: stroke, width: 2),
      ),
    );
  }
}

// ── Counter row ───────────────────────────────────────────────────────────────

/// Shows three trial status counters: completed, skipped, remaining.
///
/// Uses `completedCount` (completed + late) per the 10-trial gate rule —
/// consistent with how the domain layer counts progress.
class _CounterRow extends StatelessWidget {
  final TrialMetrics metrics;
  final Color color;

  const _CounterRow({required this.metrics, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _Counter(
          icon: Icons.check_circle_outline_rounded,
          count: metrics.completedCount,
          label: 'completed',
          iconColor: color,
          context: context,
        ),
        const SizedBox(width: 20),
        _Counter(
          icon: Icons.close_rounded,
          count: metrics.skippedCount,
          label: 'skipped',
          iconColor: AppColors.onSurfaceDim,
          context: context,
        ),
        const SizedBox(width: 20),
        _Counter(
          icon: Icons.radio_button_unchecked_rounded,
          count: metrics.pendingCount,
          label: 'remaining',
          iconColor: AppColors.onSurfaceDim,
          context: context,
        ),
      ],
    );
  }
}

class _Counter extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final Color iconColor;
  final BuildContext context;

  const _Counter({
    required this.icon,
    required this.count,
    required this.label,
    required this.iconColor,
    required this.context,
  });

  @override
  Widget build(BuildContext _) {
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: tt.labelMedium?.copyWith(
            color: AppColors.onBackground,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: tt.labelSmall?.copyWith(color: AppColors.onSurfaceDim),
        ),
      ],
    );
  }
}

// ── Reflection section ────────────────────────────────────────────────────────

/// Always-open informal reflection area — more spacious than the card footer.
///
/// Temperature selector sits in its own row above the note field, giving each
/// chip room to breathe. Note field is 3 lines. Save is a full-width button.
///
/// Reuses [SaveInformalReflectionUseCase] — the same logic as the card footer
/// but in a more comfortable layout suited to a dedicated screen.
class _DetailReflectionSection extends ConsumerStatefulWidget {
  final Pact pact;
  final List<Trial> trials;
  final Color color;

  const _DetailReflectionSection({
    required this.pact,
    required this.trials,
    required this.color,
  });

  @override
  ConsumerState<_DetailReflectionSection> createState() =>
      _DetailReflectionSectionState();
}

class _DetailReflectionSectionState
    extends ConsumerState<_DetailReflectionSection> {
  CuriosityTemperature? _selectedTemp;
  final _noteController = TextEditingController();
  bool _saving = false;
  bool _saved = false;

  bool get _hasInput =>
      _selectedTemp != null || _noteController.text.trim().isNotEmpty;

  int get _sessionNumber {
    if (widget.trials.isEmpty) return 1;
    return widget.trials.map((t) => t.sessionNumber).reduce(math.max);
  }

  Future<void> _save() async {
    if (!_hasInput || _saving) return;
    setState(() => _saving = true);

    final noteText = _noteController.text.trim();
    final result = await ref.read(saveInformalReflectionUseCaseProvider).execute(
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
        _saved = true;
        _selectedTemp = null;
        _noteController.clear();
      }),
    );

    // Reset the "saved" confirmation after 2 seconds.
    if (_saved) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) setState(() => _saved = false);
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Text(
              'Quick Reflection',
              style: tt.labelSmall?.copyWith(
                color: AppColors.onSurfaceDim,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),

            // Temperature selector — three chips in a row
            Row(
              children: [
                _DetailTempChip(
                  icon: Icons.ac_unit_rounded,
                  label: 'Cold',
                  value: CuriosityTemperature.cold,
                  selected: _selectedTemp == CuriosityTemperature.cold,
                  activeColor: widget.color,
                  onTap: () => setState(() {
                    _selectedTemp = _selectedTemp == CuriosityTemperature.cold
                        ? null
                        : CuriosityTemperature.cold;
                  }),
                ),
                const SizedBox(width: 8),
                _DetailTempChip(
                  icon: Icons.waves_rounded,
                  label: 'Warm',
                  value: CuriosityTemperature.warm,
                  selected: _selectedTemp == CuriosityTemperature.warm,
                  activeColor: widget.color,
                  onTap: () => setState(() {
                    _selectedTemp = _selectedTemp == CuriosityTemperature.warm
                        ? null
                        : CuriosityTemperature.warm;
                  }),
                ),
                const SizedBox(width: 8),
                _DetailTempChip(
                  icon: Icons.local_fire_department_rounded,
                  label: 'Fiery',
                  value: CuriosityTemperature.fiery,
                  selected: _selectedTemp == CuriosityTemperature.fiery,
                  activeColor: widget.color,
                  onTap: () => setState(() {
                    _selectedTemp =
                        _selectedTemp == CuriosityTemperature.fiery
                            ? null
                            : CuriosityTemperature.fiery;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Note field — 3 lines, with template hints
            TextField(
              controller: _noteController,
              maxLines: 3,
              minLines: 2,
              style: tt.bodySmall?.copyWith(color: AppColors.onBackground),
              decoration: InputDecoration(
                hintText: '+ what\'s working\n− what\'s not\n→ what to try next',
                hintStyle: tt.bodySmall?.copyWith(
                  color: AppColors.onSurfaceDim,
                  height: 1.6,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColors.outlineVariant, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColors.outlineVariant, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: widget.color.withValues(alpha: 0.6), width: 1.5),
                ),
              ),
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.newline,
            ),

            // Save button — slides in when there is input to save
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: _hasInput
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _saving ? null : _save,
                          style: FilledButton.styleFrom(
                            backgroundColor: widget.color.withValues(alpha: 0.15),
                            foregroundColor: widget.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: widget.color.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                          icon: _saving
                              ? SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: widget.color,
                                  ),
                                )
                              : _saved
                                  ? const Icon(Icons.check_rounded, size: 16)
                                  : const Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 16),
                          label:
                              Text(_saved ? 'Saved' : 'Save reflection'),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Detail temperature chip ───────────────────────────────────────────────────

/// Wider version of the card's _TempChip — includes a text label so it reads
/// more clearly on a dedicated screen with more room to breathe.
class _DetailTempChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final CuriosityTemperature value;
  final bool selected;
  final Color activeColor;
  final VoidCallback onTap;

  const _DetailTempChip({
    required this.icon,
    required this.label,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected
              ? activeColor.withValues(alpha: 0.15)
              : Colors.transparent,
          border: Border.all(
            color: selected ? activeColor : AppColors.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: selected ? activeColor : AppColors.onSurfaceDim,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: selected ? activeColor : AppColors.onSurfaceDim,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
