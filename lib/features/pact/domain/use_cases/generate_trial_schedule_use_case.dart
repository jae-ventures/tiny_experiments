import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/pact.dart';
import '../../../tracking/domain/models/trial.dart';

final generateTrialScheduleUseCaseProvider =
    Provider<GenerateTrialScheduleUseCase>((_) => const GenerateTrialScheduleUseCase());

class GenerateTrialScheduleUseCase {
  const GenerateTrialScheduleUseCase();

  List<Trial> execute(Pact pact, {int sessionNumber = 1, int startingSequenceIndex = 1}) {
    final now = DateTime.now();
    final offset = _cadenceOffset(pact.cadence);
    final trials = <Trial>[];

    for (int i = 0; i < pact.durationTrials; i++) {
      final scheduledDate = DateTime(
        pact.startDate.year,
        pact.startDate.month,
        pact.startDate.day,
      ).add(Duration(days: offset * i));

      trials.add(Trial(
        id: const Uuid().v4(),
        pactId: pact.id,
        sessionNumber: sessionNumber,
        sequenceIndex: startingSequenceIndex + i,
        scheduledDate: scheduledDate,
        status: TrialStatus.pending,
        createdAt: now,
      ));
    }

    return trials;
  }

  int _cadenceOffset(PactCadence cadence) => switch (cadence) {
        PactCadence.daily => 1,
        PactCadence.weekly => 7,
        PactCadence.biweekly => 14,
        PactCadence.monthly => 30,
      };
}
