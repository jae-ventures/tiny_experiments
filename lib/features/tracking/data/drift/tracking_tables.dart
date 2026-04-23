import 'package:drift/drift.dart';
import '../../../pact/data/drift/pact_tables.dart';
import '../../../pact/domain/models/pact.dart';
import '../../domain/models/trial.dart';
import '../../domain/models/reflection.dart';

class Trials extends Table {
  TextColumn get id => text()();
  TextColumn get pactId => text().references(Pacts, #id)();
  IntColumn get sessionNumber => integer()();
  IntColumn get sequenceIndex => integer()();
  DateTimeColumn get scheduledDate => dateTime()();
  TextColumn get status => textEnum<TrialStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Reflections extends Table {
  TextColumn get id => text()();
  TextColumn get pactId => text().references(Pacts, #id)();
  IntColumn get sessionNumber => integer()();
  TextColumn get kind => textEnum<ReflectionKind>()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get temperature => textEnum<CuriosityTemperature>().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get intention => text().nullable()();
  TextColumn get decision => textEnum<ReflectionDecision>().nullable()();
  TextColumn get decisionNote => text().nullable()();
  TextColumn get linkedTrialId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
