import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'companion_dao.g.dart';

/// Data Access Object for the [Companions] table.
///
/// Manages companion creatures — unlocking, evolution, and reactive queries
/// for the collections/companions UI.
@DriftAccessor(tables: [Companions])
class CompanionDao extends DatabaseAccessor<AppDatabase>
    with _$CompanionDaoMixin {
  CompanionDao(super.db);

  /// Watch all companions reactively (for collections screen).
  Stream<List<Companion>> watchAll() => select(companions).watch();

  /// Watch only unlocked companions.
  Stream<List<Companion>> watchUnlocked() =>
      (select(companions)..where((t) => t.unlocked.equals(true))).watch();

  /// Get a specific companion by ID.
  Future<Companion?> getCompanion(String id) =>
      (select(companions)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Register a new companion (initially locked).
  Future<void> registerCompanion(String id) async {
    await into(companions).insertOnConflictUpdate(
      CompanionsCompanion.insert(id: id),
    );
  }

  /// Unlock a companion.
  Future<void> unlockCompanion(String id) async {
    await (update(companions)..where((t) => t.id.equals(id))).write(
      const CompanionsCompanion(unlocked: Value(true)),
    );
  }

  /// Evolve a companion to the next stage.
  Future<void> evolveCompanion(String id) async {
    final companion = await getCompanion(id);
    if (companion == null) return;
    await (update(companions)..where((t) => t.id.equals(id))).write(
      CompanionsCompanion(
          evolutionStage: Value(companion.evolutionStage + 1)),
    );
  }
}
