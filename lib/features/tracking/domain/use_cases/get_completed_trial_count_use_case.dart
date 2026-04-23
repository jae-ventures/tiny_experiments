import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/trial.dart';
import '../tracking_repository.dart';

final getCompletedTrialCountUseCaseProvider = Provider<GetCompletedTrialCountUseCase>((ref) {
  return GetCompletedTrialCountUseCase(ref.watch(trackingRepositoryProvider));
});

class GetCompletedTrialCountUseCase {
  final TrackingRepository _repo;

  const GetCompletedTrialCountUseCase(this._repo);

  /// Returns completed + late trial count for the 10-trial minimum gate check.
  Future<Either<Failure, int>> execute(String pactId) async {
    try {
      final trials = await _repo.watchTrialsForPact(pactId).first;
      final count = trials
          .where((t) => t.status == TrialStatus.completed || t.status == TrialStatus.late)
          .length;
      return right(count);
    } catch (e, st) {
      return left(Failure('Failed to get completed trial count', error: e, stackTrace: st));
    }
  }
}
