import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pact/domain/models/pact.dart';
import '../models/card_health_state.dart';
import '../models/trial.dart';

final getCardHealthStateUseCaseProvider =
    Provider<GetCardHealthStateUseCase>((_) => const GetCardHealthStateUseCase());

class GetCardHealthStateUseCase {
  const GetCardHealthStateUseCase();

  CardHealthState execute(List<Trial> trials, PactCadence cadence) {
    // Rolling window size per spec §3.4
    final windowSize = cadence == PactCadence.daily ? 7 : 4;

    final logged = trials
        .where((t) => t.status != TrialStatus.pending)
        .toList()
      ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));

    final window = logged.take(windowSize).toList();
    if (window.isEmpty) return CardHealthState.neutral;

    final skippedInWindow = window.where((t) => t.status == TrialStatus.skipped).length;
    final skipRatio = skippedInWindow / window.length;

    final scheduledDates = trials.map((t) => _dateOnly(t.scheduledDate)).toSet();
    final extraTrials = trials
        .where((t) =>
            (t.status == TrialStatus.completed || t.status == TrialStatus.late) &&
            !scheduledDates.contains(_dateOnly(t.scheduledDate)))
        .length;

    final isDrifting = skipRatio >= 0.5;
    final isFlowing = extraTrials >= 3;

    // Conflicting signals → neutral
    if (isDrifting && isFlowing) return CardHealthState.neutral;
    if (isDrifting) return CardHealthState.drifting;
    if (isFlowing) return CardHealthState.flowing;
    return CardHealthState.neutral;
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
