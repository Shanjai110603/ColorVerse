import 'package:drift/drift.dart';

import 'database_connection.dart';
import 'tables.dart';
import 'daos/player_profile_dao.dart';
import 'daos/level_progress_dao.dart';
import 'daos/companion_dao.dart';
import 'daos/island_resources_dao.dart';
import 'daos/entitlement_dao.dart';

part 'database.g.dart';

/// The main ColorVerse database.
///
/// Uses Drift with SQLite (via FFI on native mobile/desktop and IndexedDB on web)
/// for type-safe, reactive local persistence.
@DriftDatabase(
  tables: [
    PlayerProfiles,
    LevelProgressEntries,
    Companions,
    IslandResourceEntries,
    Entitlements,
  ],
  daos: [
    PlayerProfileDao,
    LevelProgressDao,
    CompanionDao,
    IslandResourcesDao,
    EntitlementDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Creates the database.
  /// Uses conditional compilation ([constructDatabase]) to select SQLite FFI on native and WebDatabase on Web.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? constructDatabase());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Seed default player profile (singleton row)
          await into(playerProfiles).insert(
            PlayerProfilesCompanion.insert(),
          );
          // Seed default island resources (singleton row)
          await into(islandResourceEntries).insert(
            IslandResourceEntriesCompanion.insert(),
          );
        },
      );

  // DAO accessors
  @override
  PlayerProfileDao get playerProfileDao => PlayerProfileDao(this);
  @override
  LevelProgressDao get levelProgressDao => LevelProgressDao(this);
  @override
  CompanionDao get companionDao => CompanionDao(this);
  @override
  IslandResourcesDao get islandResourcesDao => IslandResourcesDao(this);
  @override
  EntitlementDao get entitlementDao => EntitlementDao(this);
}
