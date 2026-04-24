import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/trial.dart';
import '../tracking_repository.dart';

final checkDoubleSkipUseCaseProvider = Provider<CheckDoubleSkipUseCase>((ref) {
  return CheckDoubleSkipUseCase(ref.watch(trackingRepositoryProvider));
});

class CheckDoubleSkipUseCase {
  final TrackingRepository _repo;

  const CheckDoubleSkipUseCase(this._repo);

  /// Returns true if the two most recent logged trials for [pactId] are both skipped.
  Future<Either<Failure, bool>> execute(String pactId) async {
    try {
      final trials = await _repo.watchTrialsForPact(pactId).first;

      final logged = trials
          .where((t) => t.status != TrialStatus.pending)
          .toList()
        ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));

      if (logged.length < 2) return right(false);

      final doubleSkip = logged[0].status == TrialStatus.skipped &&
          logged[1].status == TrialStatus.skipped;

      return right(doubleSkip);
    } catch (e, st) {
      return left(Failure('Failed to check for double skip', error: e, stackTrace: st));
    }
  }
}
