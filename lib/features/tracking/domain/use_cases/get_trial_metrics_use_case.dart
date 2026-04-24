import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/trial.dart';
import '../models/trial_metrics.dart';

final getTrialMetricsUseCaseProvider =
    Provider<GetTrialMetricsUseCase>((_) => const GetTrialMetricsUseCase());

class GetTrialMetricsUseCase {
  const GetTrialMetricsUseCase();

  TrialMetrics execute(List<Trial> trials, {required DateTime expectedEndDate}) {
    final completed = trials.where((t) => t.status == TrialStatus.completed).length;
    final late = trials.where((t) => t.status == TrialStatus.late).length;
    final skipped = trials.where((t) => t.status == TrialStatus.skipped).length;
    final pending = trials.where((t) => t.status == TrialStatus.pending).length;

    final completedCount = completed + late;
    final loggedCount = completedCount + skipped;
    final completionRate = loggedCount > 0 ? completedCount / loggedCount : null;

    final sorted = trials.toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));

    int currentStreak = 0;
    int longestStreak = 0;
    int streakCount = 0;
    int runLength = 0;

    for (final t in sorted.reversed) {
      if (t.status == TrialStatus.pending) continue;
      if (t.status == TrialStatus.skipped) {
        runLength++;
        if (currentStreak == 0) currentStreak = runLength;
      } else {
        if (runLength > 0) {
          streakCount++;
          if (runLength > longestStreak) longestStreak = runLength;
        }
        runLength = 0;
        currentStreak = 0;
      }
    }
    if (runLength > 0) {
      streakCount++;
      if (runLength > longestStreak) longestStreak = runLength;
    }

    final completions = trials
        .where((t) =>
            (t.status == TrialStatus.completed || t.status == TrialStatus.late) &&
            t.completedAt != null)
        .toList()
      ..sort((a, b) => b.completedAt!.compareTo(a.completedAt!));

    final int? daysSinceLast = completions.isEmpty
        ? null
        : DateTime.now().difference(completions.first.completedAt!).inDays;

    final today = DateTime.now();
    final isOverdue =
        expectedEndDate.isBefore(today) && pending > 0;

    return TrialMetrics(
      completedCount: completedCount,
      skippedCount: skipped,
      pendingCount: pending,
      completionRate: completionRate,
      currentSkipStreak: currentStreak,
      longestSkipStreak: longestStreak,
      skipStreakCount: streakCount,
      daysSinceLastActivity: daysSinceLast,
      isOverdue: isOverdue,
    );
  }
}
