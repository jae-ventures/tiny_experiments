import 'package:fpdart/fpdart.dart';
import '../../../core/error/failure.dart';
import 'models/pact.dart';

abstract class PactRepository {
  Stream<List<Pact>> watchActivePacts();
  Stream<List<Pact>> watchArchivedPacts();
  Future<Either<Failure, Pact>> getPactById(String id);
  Future<Either<Failure, Unit>> savePact(Pact pact);
  Future<Either<Failure, Unit>> updatePactStatus(String id, PactStatus status);
  Future<Either<Failure, Unit>> deletePact(String id);
  Future<Either<Failure, int>> countPactsByStatus(PactStatus status);
}
