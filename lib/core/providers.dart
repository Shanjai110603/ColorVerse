import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/database.dart';
import '../storage/daos/player_profile_dao.dart';
import '../storage/daos/level_progress_dao.dart';
import '../storage/daos/companion_dao.dart';
import '../storage/daos/island_resources_dao.dart';
import '../storage/daos/entitlement_dao.dart';

// ---------------------------------------------------------------------------
// Database singleton
// ---------------------------------------------------------------------------

/// Provides the singleton [AppDatabase] instance.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// ---------------------------------------------------------------------------
// DAO providers
// ---------------------------------------------------------------------------

final playerProfileDaoProvider = Provider<PlayerProfileDao>((ref) {
  return ref.watch(appDatabaseProvider).playerProfileDao;
});

final levelProgressDaoProvider = Provider<LevelProgressDao>((ref) {
  return ref.watch(appDatabaseProvider).levelProgressDao;
});

final companionDaoProvider = Provider<CompanionDao>((ref) {
  return ref.watch(appDatabaseProvider).companionDao;
});

final islandResourcesDaoProvider = Provider<IslandResourcesDao>((ref) {
  return ref.watch(appDatabaseProvider).islandResourcesDao;
});

final entitlementDaoProvider = Provider<EntitlementDao>((ref) {
  return ref.watch(appDatabaseProvider).entitlementDao;
});

// ---------------------------------------------------------------------------
// Reactive stream providers (for UI consumption)
// ---------------------------------------------------------------------------

/// Reactive stream of the player's profile (coins, gems, XP, settings).
final playerProfileProvider = StreamProvider<PlayerProfile>((ref) {
  return ref.watch(playerProfileDaoProvider).watchProfile();
});

/// Reactive stream of all level progress entries.
final allLevelProgressProvider =
    StreamProvider<List<LevelProgressEntry>>((ref) {
  return ref.watch(levelProgressDaoProvider).watchAll();
});

/// Reactive stream of a specific level's progress.
final levelProgressProvider =
    StreamProvider.family<LevelProgressEntry?, String>((ref, levelId) {
  return ref.watch(levelProgressDaoProvider).watchLevel(levelId);
});

/// Reactive stream of all companions.
final allCompanionsProvider = StreamProvider<List<Companion>>((ref) {
  return ref.watch(companionDaoProvider).watchAll();
});

/// Reactive stream of island builder resources.
final islandResourcesProvider = StreamProvider<IslandResourceEntry>((ref) {
  return ref.watch(islandResourcesDaoProvider).watchResources();
});

/// Reactive stream of all entitlements.
final allEntitlementsProvider = StreamProvider<List<Entitlement>>((ref) {
  return ref.watch(entitlementDaoProvider).watchAll();
});

/// Reactive stream checking if a specific entitlement is active.
final entitlementActiveProvider =
    StreamProvider.family<bool, String>((ref, sku) {
  return ref.watch(entitlementDaoProvider).watchIsActive(sku);
});
