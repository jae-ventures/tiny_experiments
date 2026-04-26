// Entry point for the drift web worker.
//
// This file is compiled to web/drift_worker.js via:
//   dart compile js -O2 --no-source-maps web/drift_worker.dart -o web/drift_worker.js
//
// Re-run that command whenever the drift package version changes.
// The compiled drift_worker.js is committed to the repo so team members
// and CI don't need to run the compile step themselves.

import 'package:drift/wasm.dart';

void main() => WasmDatabase.workerMainForOpen();
