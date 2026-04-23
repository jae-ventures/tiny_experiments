import 'package:drift/drift.dart' as drift;
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database.dart' as db;
import '../../../../core/database/database_provider.dart';
import '../../../../core/error/failure.dart';
import '../../domain/models/pact.dart';
import '../../domain/pact_repository.dart';

final pactRepositoryProvider = Provider<PactRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftPactRepository(db);
});

class DriftPactRepository implements PactRepository {
  final db.AppDatabase _db;

  DriftPactRepository(this._db);

  Pact _toDomain(db.Pact data) {
    return Pact(
      id: data.id,
      action: data.action,
      cadence: data.cadence,
      durationTrials: data.durationTrials,
      startDate: data.startDate,
      endDate: data.endDate,
      status: data.status,
      createdAt: data.createdAt,
      ifCondition: data.ifCondition,
      thenAction: data.thenAction,
      hypothesis: data.hypothesis,
      temperature: data.temperature,
      reflectionIntervalTrials: data.reflectionIntervalTrials,
    );
  }

  db.PactsCompanion _toDrift(Pact domain) {
    return db.PactsCompanion.insert(
      id: domain.id,
      action: domain.action,
      cadence: domain.cadence,
      durationTrials: domain.durationTrials,
      startDate: domain.startDate,
      endDate: domain.endDate,
      status: domain.status,
      createdAt: domain.createdAt,
      ifCondition: drift.Value(domain.ifCondition),
      thenAction: drift.Value(domain.thenAction),
      hypothesis: drift.Value(domain.hypothesis),
      temperature: drift.Value(domain.temperature),
      reflectionIntervalTrials: drift.Value(domain.reflectionIntervalTrials),
    );
  }

  @override
  Stream<List<Pact>> watchActivePacts() {
    return (_db.select(_db.pacts)
          ..where((p) => p.status.equalsValue(PactStatus.active)))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Stream<List<Pact>> watchArchivedPacts() {
    return (_db.select(_db.pacts)..where(
          (p) =>
              p.status.equalsValue(PactStatus.completed) |
              p.status.equalsValue(PactStatus.abandoned),
        ))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<Either<Failure, Pact>> getPactById(String id) async {
    try {
      final data = await (_db.select(
        _db.pacts,
      )..where((p) => p.id.equals(id))).getSingle();
      return right(_toDomain(data));
    } catch (e, st) {
      return left(
        Failure('Failed to get Pact by ID', error: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> savePact(Pact pact) async {
    try {
      await _db
          .into(_db.pacts)
          .insert(_toDrift(pact), mode: drift.InsertMode.insertOrReplace);
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to save Pact', error: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePactStatus(
    String id,
    PactStatus status,
  ) async {
    try {
      await (_db.update(_db.pacts)..where((p) => p.id.equals(id))).write(
        db.PactsCompanion(status: drift.Value(status)),
      );
      return right(unit);
    } catch (e, st) {
      return left(
        Failure('Failed to update Pact status', error: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePact(String id) async {
    try {
      await (_db.delete(_db.pacts)..where((p) => p.id.equals(id))).go();
      return right(unit);
    } catch (e, st) {
      return left(Failure('Failed to delete Pact', error: e, stackTrace: st));
    }
  }
}
