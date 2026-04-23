import 'package:freezed_annotation/freezed_annotation.dart';

part 'trial.freezed.dart';

enum TrialStatus {
  pending,    // scheduled, not yet due or window not yet closed
  completed,  // logged on or before scheduledDate
  late,       // logged after scheduledDate has passed (within grace window)
  skipped,    // automatically applied when the trial window closes without a log
}

@freezed
class Trial with _$Trial {
  const factory Trial({
    required String id,                 // UUID
    required String pactId,
    required int sessionNumber,         // 1 = original, 2 = first resume, etc.
    required int sequenceIndex,         // position in full trial schedule (1-based)
    required DateTime scheduledDate,    // immutable ground truth for this trial slot
    required TrialStatus status,        // pending | completed | skipped | late
    required DateTime createdAt,        // when this trial record was generated
    DateTime? completedAt,              // when the user actually logged it (may differ from scheduledDate)
    String? note,                       // optional free-text note logged at check-in
  }) = _Trial;
}
