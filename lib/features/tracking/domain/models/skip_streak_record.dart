class SkipStreakRecord {
  final int length;
  final DateTime startDate;
  final DateTime endDate;
  // 'completion' | 'pact_paused' | 'pact_ended'
  final String endedBy;

  const SkipStreakRecord({
    required this.length,
    required this.startDate,
    required this.endDate,
    required this.endedBy,
  });
}
