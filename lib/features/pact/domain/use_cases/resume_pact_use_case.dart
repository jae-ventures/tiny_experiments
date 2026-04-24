import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../models/pact.dart';
import '../pact_repository.dart';
import 'get_slot_availability_use_case.dart';

final resumePactUseCaseProvider = Provider<ResumePactUseCase>((ref) {
  return ResumePactUseCase(
    ref.watch(pactRepositoryProvider),
    ref.watch(getSlotAvailabilityUseCaseProvider),
  );
});

class ResumePactUseCase {
  final PactRepository _repo;
  final GetSlotAvailabilityUseCase _getSlotAvailability;

  const ResumePactUseCase(this._repo, this._getSlotAvailability);

  Future<Either<Failure, Unit>> execute(String pactId) async {
    Failure? failure;
    final slotResult = await _getSlotAvailability.execute();
    slotResult.fold((f) => failure = f, (_) {});
    if (failure != null) return left(failure!);

    final slotState = slotResult.fold((_) => throw StateError(''), (s) => s);
    if (!slotState.hasAvailableSlot) {
      return left(const Failure('No available PACT slots. Complete an existing PACT to resume this one.'));
    }

    return _repo.updatePactStatus(pactId, PactStatus.active);
  }
}
