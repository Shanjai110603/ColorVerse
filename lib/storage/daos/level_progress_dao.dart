import 'dart:convert';

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'level_progress_dao.g.dart';

/// Data Access Object for the [LevelProgressEntries] table.
///
/// Provides reactive stream queries for level progress and incremental
/// fill-state saving. The incremental save ensures crash resilience —
/// each filled region is persisted immediately (§8 mid-level resume).
@DriftAccessor(tables: [LevelProgressEntries])
class LevelProgressDao extends DatabaseAccessor<AppDatabase>
    with _$LevelProgressDaoMixin {
  LevelProgressDao(super.db);

  /// Watch all level progress entries reactively (for level list screen).
  Stream<List<LevelProgressEntry>> watchAll() =>
      select(levelProgressEntries).watch();

  /// Watch a single level's progress reactively (for in-level resume).
  Stream<LevelProgressEntry?> watchLevel(String levelId) =>
      (select(levelProgressEntries)
            ..where((t) => t.levelId.equals(levelId)))
          .watchSingleOrNull();

  /// Get a single level's progress once (non-reactive).
  Future<LevelProgressEntry?> getLevel(String levelId) =>
      (select(levelProgressEntries)
            ..where((t) => t.levelId.equals(levelId)))
          .getSingleOrNull();

  /// Ensure a progress entry exists for the given level.
  /// Creates one with 'not_started' status if it doesn't exist.
  Future<void> ensureExists(String levelId) async {
    final existing = await getLevel(levelId);
    if (existing == null) {
      await into(levelProgressEntries).insert(
        LevelProgressEntriesCompanion.insert(levelId: levelId),
      );
    }
  }

  /// Mark a single region as filled — incremental save for crash resilience.
  ///
  /// Reads the current [filledRegionIds] JSON list, appends [regionId] if
  /// not already present, and writes back. Also sets status to 'in_progress'
  /// if it was 'not_started'.
  Future<void> markRegionFilled(String levelId, int regionId) async {
    await ensureExists(levelId);
    final entry = (await getLevel(levelId))!;

    final List<dynamic> currentIds = jsonDecode(entry.filledRegionIds);
    if (currentIds.contains(regionId)) return; // already filled

    currentIds.add(regionId);

    await (update(levelProgressEntries)
          ..where((t) => t.levelId.equals(levelId)))
        .write(
      LevelProgressEntriesCompanion(
        filledRegionIds: Value(jsonEncode(currentIds)),
        status: const Value('in_progress'),
      ),
    );
  }

  /// Mark a level as completed with a star rating.
  Future<void> markCompleted(String levelId, int stars) async {
    await ensureExists(levelId);
    await (update(levelProgressEntries)
          ..where((t) => t.levelId.equals(levelId)))
        .write(
      LevelProgressEntriesCompanion(
        status: const Value('completed'),
        completedAt: Value(DateTime.now()),
        starRating: Value(stars),
      ),
    );
  }

  /// Get the list of filled region IDs for a level (decoded from JSON).
  Future<List<int>> getFilledRegionIds(String levelId) async {
    final entry = await getLevel(levelId);
    if (entry == null) return [];
    final List<dynamic> ids = jsonDecode(entry.filledRegionIds);
    return ids.cast<int>();
  }

  /// Reset a level's progress (for replay).
  Future<void> resetLevel(String levelId) async {
    await (update(levelProgressEntries)
          ..where((t) => t.levelId.equals(levelId)))
        .write(
      const LevelProgressEntriesCompanion(
        status: Value('not_started'),
        filledRegionIds: Value('[]'),
        completedAt: Value(null),
        starRating: Value(null),
      ),
    );
  }
}
