import 'package:fpdart/fpdart.dart';
import '../../../core/error/failure.dart';
import 'models/trial.dart';
import 'models/reflection.dart';

abstract class TrackingRepository {
  // Trials
  Stream<List<Trial>> watchTrialsForPact(String pactId);
  Future<Either<Failure, Trial>> getTrialById(String id);
  Future<Either<Failure, Unit>> logTrial({
    required String trialId,
    required DateTime completedAt,
    required TrialStatus status,
    String? note,
  });
  Future<Either<Failure, Unit>> skipTrial(String trialId);
  Future<Either<Failure, Unit>> undoTrialLog(String trialId);

  // Reflections
  Stream<List<Reflection>> watchReflectionsForPact(String pactId);
  Future<Either<Failure, Unit>> saveReflection(Reflection reflection);
  Future<Either<Failure, Unit>> updateReflection(Reflection reflection);
}
