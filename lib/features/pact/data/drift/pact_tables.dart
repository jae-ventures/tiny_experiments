import 'package:drift/drift.dart';
import '../../domain/models/pact.dart';

class Pacts extends Table {
  TextColumn get id => text()();
  TextColumn get action => text()();
  TextColumn get cadence => textEnum<PactCadence>()();
  IntColumn get durationTrials => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get status => textEnum<PactStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get ifCondition => text().nullable()();
  TextColumn get thenAction => text().nullable()();
  TextColumn get hypothesis => text().nullable()();
  TextColumn get temperature => textEnum<CuriosityTemperature>().nullable()();
  IntColumn get reflectionIntervalTrials => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
