import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/trial.dart';
import '../tracking_repository.dart';

final logTrialUseCaseProvider = Provider<LogTrialUseCase>((ref) {
  return LogTrialUseCase(ref.watch(trackingRepositoryProvider));
});

class LogTrialUseCase {
  final TrackingRepository _repo;

  const LogTrialUseCase(this._repo);

  Future<Either<Failure, Unit>> execute(String trialId, {String? note}) async {
    Failure? failure;
    Trial? trial;

    (await _repo.getTrialById(trialId)).fold((f) => failure = f, (t) => trial = t);
    if (failure != null) return left(failure!);

    if (trial!.status != TrialStatus.pending) {
      return left(Failure('Trial ${trial!.status.name} — cannot log again'));
    }

    final today = _dateOnly(DateTime.now());
    final scheduled = _dateOnly(trial!.scheduledDate);

    if (today.isBefore(scheduled)) {
      return left(const Failure('Cannot log a trial before its scheduled date'));
    }

    final status = today.isAtSameMomentAs(scheduled) ? TrialStatus.completed : TrialStatus.late;

    return _repo.logTrial(
      trialId: trialId,
      completedAt: DateTime.now(),
      status: status,
      note: note,
    );
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
