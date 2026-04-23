import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/trial.dart';
import '../tracking_repository.dart';

final undoTrialLogUseCaseProvider = Provider<UndoTrialLogUseCase>((ref) {
  return UndoTrialLogUseCase(ref.watch(trackingRepositoryProvider));
});

class UndoTrialLogUseCase {
  final TrackingRepository _repo;

  const UndoTrialLogUseCase(this._repo);

  Future<Either<Failure, Unit>> execute(String trialId) async {
    Failure? failure;
    Trial? trial;

    (await _repo.getTrialById(trialId)).fold((f) => failure = f, (t) => trial = t);
    if (failure != null) return left(failure!);

    if (trial!.status != TrialStatus.completed && trial!.status != TrialStatus.late) {
      return left(const Failure('Only completed or late trials can be undone'));
    }

    final completedAt = trial!.completedAt;
    if (completedAt == null) {
      return left(const Failure('Trial has no completion timestamp'));
    }

    final today = DateTime.now();
    final sameDay = completedAt.year == today.year &&
        completedAt.month == today.month &&
        completedAt.day == today.day;

    if (!sameDay) {
      return left(const Failure('Undo is only available on the same calendar day as the log'));
    }

    return _repo.undoTrialLog(trialId);
  }
}
