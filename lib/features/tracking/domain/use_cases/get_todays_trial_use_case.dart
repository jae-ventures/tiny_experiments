import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/trial.dart';
import '../tracking_repository.dart';

final getTodaysTrialUseCaseProvider = Provider<GetTodaysTrialUseCase>((ref) {
  return GetTodaysTrialUseCase(ref.watch(trackingRepositoryProvider));
});

class GetTodaysTrialUseCase {
  final TrackingRepository _repo;

  const GetTodaysTrialUseCase(this._repo);

  /// Returns the most actionable pending trial for [pactId] — today's scheduled
  /// trial, or the most recent overdue pending trial if today has none scheduled.
  /// Returns null if no actionable trial exists.
  Future<Either<Failure, Trial?>> execute(String pactId) async {
    try {
      final trials = await _repo.watchTrialsForPact(pactId).first;
      final today = _dateOnly(DateTime.now());

      final actionable = trials
          .where((t) =>
              t.status == TrialStatus.pending &&
              !_dateOnly(t.scheduledDate).isAfter(today))
          .toList()
        ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));

      return right(actionable.isEmpty ? null : actionable.first);
    } catch (e, st) {
      return left(Failure('Failed to get today\'s trial', error: e, stackTrace: st));
    }
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
