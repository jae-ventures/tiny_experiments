import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/domain/models/pact.dart';
import '../../data/repositories/drift_tracking_repository.dart';
import '../models/reflection.dart';
import '../tracking_repository.dart';

final saveInformalReflectionUseCaseProvider = Provider<SaveInformalReflectionUseCase>((ref) {
  return SaveInformalReflectionUseCase(ref.watch(trackingRepositoryProvider));
});

class SaveInformalReflectionUseCase {
  final TrackingRepository _repo;

  const SaveInformalReflectionUseCase(this._repo);

  Future<Either<Failure, Unit>> execute({
    required String pactId,
    required int sessionNumber,
    CuriosityTemperature? temperature,
    String? note,
    String? intention,
    String? linkedTrialId,
  }) async {
    if (temperature == null && note == null && intention == null) {
      return left(const Failure('At least one field must be provided for an informal reflection'));
    }

    final now = DateTime.now();
    final reflection = Reflection(
      id: const Uuid().v4(),
      pactId: pactId,
      sessionNumber: sessionNumber,
      kind: ReflectionKind.informal,
      loggedAt: now,
      createdAt: now,
      temperature: temperature,
      note: note,
      intention: intention,
      linkedTrialId: linkedTrialId,
    );

    return _repo.saveReflection(reflection);
  }
}
