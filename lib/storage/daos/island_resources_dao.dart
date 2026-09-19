import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'island_resources_dao.g.dart';

/// Data Access Object for the [IslandResourceEntries] table.
///
/// Manages Island Builder resources (wood, stone, crystal, food, gold).
/// Single row (singleton) — resources are added from level completion
/// rewards and consumed by Island Builder construction costs.
@DriftAccessor(tables: [IslandResourceEntries])
class IslandResourcesDao extends DatabaseAccessor<AppDatabase>
    with _$IslandResourcesDaoMixin {
  IslandResourcesDao(super.db);

  /// Watch island resources reactively (for Island Builder UI).
  Stream<IslandResourceEntry> watchResources() =>
      (select(islandResourceEntries)..where((t) => t.id.equals(1)))
          .watchSingle();

  /// Get current resources once (non-reactive).
  Future<IslandResourceEntry> getResources() =>
      (select(islandResourceEntries)..where((t) => t.id.equals(1)))
          .getSingle();

  /// Add resources from level completion rewards.
  Future<void> addResources({
    int wood = 0,
    int stone = 0,
    int crystal = 0,
    int food = 0,
    int gold = 0,
  }) async {
    final current = await getResources();
    await (update(islandResourceEntries)..where((t) => t.id.equals(1)))
        .write(
      IslandResourceEntriesCompanion(
        wood: Value(current.wood + wood),
        stone: Value(current.stone + stone),
        crystal: Value(current.crystal + crystal),
        food: Value(current.food + food),
        gold: Value(current.gold + gold),
      ),
    );
  }

  /// Spend resources for Island Builder construction.
  /// Returns true if the player had enough resources, false otherwise.
  Future<bool> spendResources({
    int wood = 0,
    int stone = 0,
    int crystal = 0,
    int food = 0,
    int gold = 0,
  }) async {
    final current = await getResources();
    if (current.wood < wood ||
        current.stone < stone ||
        current.crystal < crystal ||
        current.food < food ||
        current.gold < gold) {
      return false;
    }
    await (update(islandResourceEntries)..where((t) => t.id.equals(1)))
        .write(
      IslandResourceEntriesCompanion(
        wood: Value(current.wood - wood),
        stone: Value(current.stone - stone),
        crystal: Value(current.crystal - crystal),
        food: Value(current.food - food),
        gold: Value(current.gold - gold),
      ),
    );
    return true;
  }
}
