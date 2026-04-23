import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../models/pact.dart';
import '../pact_repository.dart';

final completePactUseCaseProvider = Provider<CompletePactUseCase>((ref) {
  return CompletePactUseCase(ref.watch(pactRepositoryProvider));
});

class CompletePactUseCase {
  final PactRepository _repo;

  const CompletePactUseCase(this._repo);

  Future<Either<Failure, Unit>> execute(String pactId) =>
      _repo.updatePactStatus(pactId, PactStatus.completed);
}
