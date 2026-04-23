import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/skip_streak_record.dart';
import '../models/trial.dart';

final getSkipStreakHistoryUseCaseProvider =
    Provider<GetSkipStreakHistoryUseCase>((_) => const GetSkipStreakHistoryUseCase());

class GetSkipStreakHistoryUseCase {
  const GetSkipStreakHistoryUseCase();

  List<SkipStreakRecord> execute(List<Trial> trials) {
    final sorted = trials
        .where((t) => t.status != TrialStatus.pending)
        .toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));

    final records = <SkipStreakRecord>[];
    DateTime? streakStart;
    DateTime? streakEnd;
    int length = 0;

    for (int i = 0; i < sorted.length; i++) {
      final trial = sorted[i];

      if (trial.status == TrialStatus.skipped) {
        streakStart ??= trial.scheduledDate;
        streakEnd = trial.scheduledDate;
        length++;
      } else {
        if (length > 0) {
          records.add(SkipStreakRecord(
            length: length,
            startDate: streakStart!,
            endDate: streakEnd!,
            endedBy: 'completion',
          ));
          length = 0;
          streakStart = null;
          streakEnd = null;
        }
      }
    }

    // Close any open streak at end of trial list
    if (length > 0) {
      records.add(SkipStreakRecord(
        length: length,
        startDate: streakStart!,
        endDate: streakEnd!,
        endedBy: 'pact_ended',
      ));
    }

    return records;
  }
}
