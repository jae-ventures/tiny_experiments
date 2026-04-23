class TrialMetrics {
  final int completedCount;
  final int skippedCount;
  final int pendingCount;
  final double? completionRate;
  final int currentSkipStreak;
  final int longestSkipStreak;
  final int skipStreakCount;
  final int? daysSinceLastActivity;
  final bool isOverdue;

  const TrialMetrics({
    required this.completedCount,
    required this.skippedCount,
    required this.pendingCount,
    required this.completionRate,
    required this.currentSkipStreak,
    required this.longestSkipStreak,
    required this.skipStreakCount,
    required this.daysSinceLastActivity,
    required this.isOverdue,
  });

  int get loggedCount => completedCount + skippedCount;
}
