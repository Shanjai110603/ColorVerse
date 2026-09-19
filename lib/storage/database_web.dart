// ignore: deprecated_member_use
import 'package:drift/web.dart';
import 'package:drift/drift.dart';

/// Web query executor implementation (Chrome/Web via JS IndexedDB).
QueryExecutor constructDatabase() {
  // ignore: deprecated_member_use
  return WebDatabase('colorverse');
}
