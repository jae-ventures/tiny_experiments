import 'package:drift/drift.dart';
import 'connection.dart' as impl;
import '../../features/pact/data/drift/pact_tables.dart';
import '../../features/tracking/data/drift/tracking_tables.dart';
import '../../features/pact/domain/models/pact.dart';
import '../../features/tracking/domain/models/trial.dart';
import '../../features/tracking/domain/models/reflection.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Pacts, Trials, Reflections])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}
