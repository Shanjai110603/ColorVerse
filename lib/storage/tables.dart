import 'package:drift/drift.dart';

/// Player profile table — stores currencies, XP, and user preferences.
///
/// Only one row expected (singleton profile). Seeded on first app launch.
/// All settings that affect gameplay rendering (colorblind, sound, haptics)
/// live here for reactive observation via Drift streams.
class PlayerProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get coins => integer().withDefault(const Constant(0))();
  IntColumn get gems => integer().withDefault(const Constant(0))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  BoolColumn get colorblindMode =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get soundOn => boolean().withDefault(const Constant(true))();
  BoolColumn get hapticsOn => boolean().withDefault(const Constant(true))();
}

/// Per-level progress tracking.
///
/// [filledRegionIds] is a JSON-encoded list of integer region IDs that have
/// been filled. Written incrementally on each fill event (§8) so a crash
/// or force-close doesn't lose progress.
///
/// [status] is one of: 'not_started', 'in_progress', 'completed'.
class LevelProgressEntries extends Table {
  TextColumn get levelId => text()();
  TextColumn get status =>
      text().withDefault(const Constant('not_started'))();
  TextColumn get filledRegionIds =>
      text().withDefault(const Constant('[]'))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get starRating => integer().nullable()();

  @override
  Set<Column> get primaryKey => {levelId};
}

/// Companion creatures that the player can unlock and evolve.
class Companions extends Table {
  TextColumn get id => text()();
  BoolColumn get unlocked =>
      boolean().withDefault(const Constant(false))();
  IntColumn get evolutionStage =>
      integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Island Builder resources — tied to world-specific level completion rewards.
///
/// Single row (singleton). Forest levels yield wood, mountain levels yield
/// stone, etc. Resources are consumed by Island Builder construction.
class IslandResourceEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wood => integer().withDefault(const Constant(0))();
  IntColumn get stone => integer().withDefault(const Constant(0))();
  IntColumn get crystal => integer().withDefault(const Constant(0))();
  IntColumn get food => integer().withDefault(const Constant(0))();
  IntColumn get gold => integer().withDefault(const Constant(0))();
}

/// IAP entitlements — purchased items and their active state.
///
/// Stored via flutter_secure_storage for the actual receipt validation,
/// but mirrored here for reactive UI queries (e.g., "is ads-removed active?").
class Entitlements extends Table {
  TextColumn get sku => text()();
  DateTimeColumn get purchasedAt => dateTime()();
  BoolColumn get active =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {sku};
}
