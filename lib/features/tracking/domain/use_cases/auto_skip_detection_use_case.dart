import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../../../pact/domain/pact_repository.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/trial.dart';
import '../tracking_repository.dart';

final autoSkipDetectionUseCaseProvider = Provider<AutoSkipDetectionUseCase>((ref) {
  return AutoSkipDetectionUseCase(
    ref.watch(pactRepositoryProvider),
    ref.watch(trackingRepositoryProvider),
  );
});

class AutoSkipDetectionUseCase {
  final PactRepository _pactRepo;
  final TrackingRepository _trackingRepo;

  const AutoSkipDetectionUseCase(this._pactRepo, this._trackingRepo);

  /// Scans all active PACTs for overdue pending trials and marks them skipped.
  /// Returns the IDs of PACTs where at least one new skip was recorded,
  /// so the caller can invoke [CheckDoubleSkipUseCase] for those PACTs.
  Future<Either<Failure, List<String>>> execute() async {
    try {
      final activePacts = await _pactRepo.watchActivePacts().first;
      final today = _dateOnly(DateTime.now());
      final pactsWithNewSkips = <String>[];

      for (final pact in activePacts) {
        final trials = await _trackingRepo.watchTrialsForPact(pact.id).first;
        final sorted = trials.toList()
          ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));

        bool hadNewSkip = false;

        for (int i = 0; i < sorted.length; i++) {
          final trial = sorted[i];
          if (trial.status != TrialStatus.pending) continue;

          final scheduled = _dateOnly(trial.scheduledDate);
          if (!scheduled.isBefore(today)) continue;

          // Window = next trial's scheduledDate, or today for last trial
          final windowEnd = (i + 1 < sorted.length)
              ? _dateOnly(sorted[i + 1].scheduledDate)
              : today;

          if (!today.isBefore(windowEnd)) {
            await _trackingRepo.skipTrial(trial.id);
            hadNewSkip = true;
          }
        }

        if (hadNewSkip) pactsWithNewSkips.add(pact.id);
      }

      return right(pactsWithNewSkips);
    } catch (e, st) {
      return left(Failure('Auto-skip detection failed', error: e, stackTrace: st));
    }
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
