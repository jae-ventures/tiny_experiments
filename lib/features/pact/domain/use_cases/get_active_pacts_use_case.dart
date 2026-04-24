import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../models/pact.dart';
import '../pact_repository.dart';

final getActivePactsUseCaseProvider = Provider<GetActivePactsUseCase>((ref) {
  return GetActivePactsUseCase(ref.watch(pactRepositoryProvider));
});

class GetActivePactsUseCase {
  final PactRepository _repo;

  const GetActivePactsUseCase(this._repo);

  Stream<List<Pact>> execute() => _repo.watchActivePacts();
}
