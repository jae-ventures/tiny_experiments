import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../models/pact.dart';
import '../pact_repository.dart';

final pausePactUseCaseProvider = Provider<PausePactUseCase>((ref) {
  return PausePactUseCase(ref.watch(pactRepositoryProvider));
});

class PausePactUseCase {
  final PactRepository _repo;

  const PausePactUseCase(this._repo);

  Future<Either<Failure, Unit>> execute(String pactId) =>
      _repo.updatePactStatus(pactId, PactStatus.paused);
}
