import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../models/pact.dart';
import '../models/slot_state.dart';
import '../pact_repository.dart';

final getSlotAvailabilityUseCaseProvider = Provider<GetSlotAvailabilityUseCase>((ref) {
  return GetSlotAvailabilityUseCase(ref.watch(pactRepositoryProvider));
});

class GetSlotAvailabilityUseCase {
  final PactRepository _repo;

  const GetSlotAvailabilityUseCase(this._repo);

  Future<Either<Failure, SlotState>> execute() async {
    Failure? failure;
    int activeCount = 0, pausedCount = 0, completedCount = 0;

    (await _repo.countPactsByStatus(PactStatus.active))
        .fold((f) => failure = f, (c) => activeCount = c);
    if (failure != null) return left(failure!);

    (await _repo.countPactsByStatus(PactStatus.paused))
        .fold((f) => failure = f, (c) => pausedCount = c);
    if (failure != null) return left(failure!);

    (await _repo.countPactsByStatus(PactStatus.completed))
        .fold((f) => failure = f, (c) => completedCount = c);
    if (failure != null) return left(failure!);

    return right(SlotState(
      totalSlots: _computeTotalSlots(completedCount),
      usedSlots: activeCount + pausedCount,
      completedPactCount: completedCount,
      pactsUntilNextSlot: _pactsUntilNextSlot(completedCount),
    ));
  }

  // Thresholds from spec §6.1: 0→1, 3→2, 9→3, 21→4 slots
  int _computeTotalSlots(int completedCount) {
    if (completedCount >= 21) return 4;
    if (completedCount >= 9) return 3;
    if (completedCount >= 3) return 2;
    return 1;
  }

  int? _pactsUntilNextSlot(int completedCount) {
    if (completedCount >= 21) return null;
    if (completedCount >= 9) return 21 - completedCount;
    if (completedCount >= 3) return 9 - completedCount;
    return 3 - completedCount;
  }
}
