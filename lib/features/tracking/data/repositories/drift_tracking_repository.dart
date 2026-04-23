import 'package:drift/drift.dart' as drift;
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database.dart' as db;
import '../../../../core/database/database_provider.dart';
import '../../../../core/error/failure.dart';
import '../../domain/models/trial.dart';
import '../../domain/models/reflection.dart';
import '../../domain/tracking_repository.dart';

final trackingRepositoryProvider = Provider<TrackingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftTrackingRepository(db);
});

class DriftTrackingRepository implements TrackingRepository {
  final db.AppDatabase _db;

  DriftTrackingRepository(this._db);

  Trial _trialToDomain(db.Trial data) {
    return Trial(
      id: data.id,
      pactId: data.pactId,
      sessionNumber: data.sessionNumber,
      sequenceIndex: data.sequenceIndex,
      scheduledDate: data.scheduledDate,
      status: data.status,
      createdAt: data.createdAt,
      completedAt: data.completedAt,
      note: data.note,
    );
  }

  Reflection _reflectionToDomain(db.Reflection data) {
    return Reflection(
      id: data.id,
      pactId: data.pactId,
      sessionNumber: data.sessionNumber,
      kind: data.kind,
      loggedAt: data.loggedAt,
      createdAt: data.createdAt,
      temperature: data.temperature,
      note: data.note,
      intention: data.intention,
      decision: data.decision,
      decisionNote: data.decisionNote,
      linkedTrialId: data.linkedTrialId,
    );
  }

  @override
  Stream<List<Trial>> watchTrialsForPact(String pactId) {
    return (_db.select(_db.trials)..where((t) => t.pactId.equals(pactId)))
        .watch()
        .map((rows) => rows.map(_trialToDomain).toList());
  }

  @override
  Future<Either<Failure, Trial>> getTrialById(String id) async {
    try {
      final data = await (_db.select(_db.trials)..where((t) => t.id.equals(id))).getSingle();
      return right(_trialToDomain(data));
    } catch (e, st) {
      return left(Failure('Failed to get Trial by ID', error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, Unit>> logTrial({
    required String trialId,
    required DateTime completedAt,
    required TrialStatus status,
    String? note,
  }) async {
    try {
      await (_db.update(_db.trials)..where((t) => t.id.equals(trialId))).write(
        db.TrialsCompanion(
          completedAt: drift.Value(completedAt),
          status: drift.Value(status),
          note: drift.Value(note),
        ),
      );
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to log Trial', error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, Unit>> skipTrial(String trialId) async {
    try {
      await (_db.update(_db.trials)..where((t) => t.id.equals(trialId))).write(
        db.TrialsCompanion(status: drift.Value(TrialStatus.skipped)),
      );
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to skip Trial', error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, Unit>> undoTrialLog(String trialId) async {
    try {
      await (_db.update(_db.trials)..where((t) => t.id.equals(trialId))).write(
        const db.TrialsCompanion(
          completedAt: drift.Value(null),
          status: drift.Value(TrialStatus.pending),
          note: drift.Value(null),
        ),
      );
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to undo Trial log', error: e, stackTrace: st));
    }
  }

  @override
  Stream<List<Reflection>> watchReflectionsForPact(String pactId) {
    return (_db.select(_db.reflections)..where((r) => r.pactId.equals(pactId)))
        .watch()
        .map((rows) => rows.map(_reflectionToDomain).toList());
  }

  @override
  Future<Either<Failure, Unit>> saveReflection(Reflection reflection) async {
    try {
      final companion = db.ReflectionsCompanion.insert(
        id: reflection.id,
        pactId: reflection.pactId,
        sessionNumber: reflection.sessionNumber,
        kind: reflection.kind,
        loggedAt: reflection.loggedAt,
        createdAt: reflection.createdAt,
        temperature: drift.Value(reflection.temperature),
        note: drift.Value(reflection.note),
        intention: drift.Value(reflection.intention),
        decision: drift.Value(reflection.decision),
        decisionNote: drift.Value(reflection.decisionNote),
        linkedTrialId: drift.Value(reflection.linkedTrialId),
      );
      await _db.into(_db.reflections).insert(companion, mode: drift.InsertMode.insertOrReplace);
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to save Reflection', error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateReflection(Reflection reflection) async {
    try {
      await (_db.update(_db.reflections)..where((r) => r.id.equals(reflection.id))).write(
        db.ReflectionsCompanion(
          temperature: drift.Value(reflection.temperature),
          note: drift.Value(reflection.note),
          intention: drift.Value(reflection.intention),
        ),
      );
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to update Reflection', error: e, stackTrace: st));
    }
  }
}
