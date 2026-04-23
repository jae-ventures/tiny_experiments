import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../../../tracking/data/repositories/drift_tracking_repository.dart';
import '../models/pact.dart';
import '../pact_repository.dart';
import '../../../tracking/domain/models/trial.dart';
import '../../../tracking/domain/tracking_repository.dart';

final abandonPactUseCaseProvider = Provider<AbandonPactUseCase>((ref) {
  return AbandonPactUseCase(
    ref.watch(pactRepositoryProvider),
    ref.watch(trackingRepositoryProvider),
  );
});

class AbandonPactUseCase {
  final PactRepository _pactRepo;
  final TrackingRepository _trackingRepo;

  const AbandonPactUseCase(this._pactRepo, this._trackingRepo);

  // The 10-trial minimum gate uses completedCount (completed + late), per spec.
  static const int _minimumCompletedTrials = 10;

  Future<Either<Failure, Unit>> execute(String pactId) async {
    try {
      final trials = await _trackingRepo.watchTrialsForPact(pactId).first;
      final completedCount = trials
          .where((t) => t.status == TrialStatus.completed || t.status == TrialStatus.late)
          .length;

      if (completedCount < _minimumCompletedTrials) {
        return left(Failure(
          'At least $_minimumCompletedTrials completed trials are required before abandoning a PACT. '
          'You have $completedCount so far.',
        ));
      }

      return _pactRepo.updatePactStatus(pactId, PactStatus.abandoned);
    } catch (e, st) {
      return left(Failure('Failed to abandon PACT', error: e, stackTrace: st));
    }
  }
}
