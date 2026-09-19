import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Native query executor implementation (Android, iOS, Windows, macOS, Linux, VM unit tests).
QueryExecutor constructDatabase() {
  return driftDatabase(name: 'colorverse');
}
