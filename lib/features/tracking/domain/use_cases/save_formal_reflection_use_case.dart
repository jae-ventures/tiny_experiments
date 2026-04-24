import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../../../pact/domain/models/pact.dart';
import '../../../pact/domain/pact_repository.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/reflection.dart';
import '../tracking_repository.dart';

final saveFormalReflectionUseCaseProvider = Provider<SaveFormalReflectionUseCase>((ref) {
  return SaveFormalReflectionUseCase(
    ref.watch(trackingRepositoryProvider),
    ref.watch(pactRepositoryProvider),
  );
});

class SaveFormalReflectionUseCase {
  final TrackingRepository _trackingRepo;
  final PactRepository _pactRepo;

  const SaveFormalReflectionUseCase(this._trackingRepo, this._pactRepo);

  Future<Either<Failure, Unit>> execute({
    required String pactId,
    required int sessionNumber,
    required ReflectionDecision decision,
    required CuriosityTemperature temperature,
    String? note,
    String? intention,
    String? decisionNote,
    String? linkedTrialId,
  }) async {
    final now = DateTime.now();
    final reflection = Reflection(
      id: const Uuid().v4(),
      pactId: pactId,
      sessionNumber: sessionNumber,
      kind: ReflectionKind.formal,
      loggedAt: now,
      createdAt: now,
      temperature: temperature,
      note: note,
      intention: intention,
      decision: decision,
      decisionNote: decisionNote,
      linkedTrialId: linkedTrialId,
    );

    Failure? failure;
    (await _trackingRepo.saveReflection(reflection)).fold((f) => failure = f, (_) {});
    if (failure != null) return left(failure!);

    // Delegate lifecycle transition for pause/pivot decisions
    final targetStatus = switch (decision) {
      ReflectionDecision.pause => PactStatus.paused,
      ReflectionDecision.pivot => PactStatus.abandoned,
      ReflectionDecision.persist => null,
    };

    if (targetStatus != null) {
      (await _pactRepo.updatePactStatus(pactId, targetStatus))
          .fold((f) => failure = f, (_) {});
      if (failure != null) return left(failure!);
    }

    return right(unit);
  }
}
