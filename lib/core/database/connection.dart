import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor connect() {
  return driftDatabase(
    name: 'tiny_experiments',
    // Web: points to assets that must live in web/ — see web/drift_worker.dart
    // and the sqlite3.wasm download instructions in CLAUDE.md § Web Setup.
    // On native platforms (iOS/Android/desktop) this parameter is ignored.
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
