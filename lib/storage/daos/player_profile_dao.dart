import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'player_profile_dao.g.dart';

/// Data Access Object for the [PlayerProfiles] table.
///
/// Provides reactive stream queries for the singleton player profile
/// and typed mutation methods for currency/XP changes and settings updates.
@DriftAccessor(tables: [PlayerProfiles])
class PlayerProfileDao extends DatabaseAccessor<AppDatabase>
    with _$PlayerProfileDaoMixin {
  PlayerProfileDao(super.db);

  /// Watch the singleton player profile reactively.
  /// UI widgets should use this to auto-update currency counters, etc.
  Stream<PlayerProfile> watchProfile() =>
      (select(playerProfiles)..where((t) => t.id.equals(1))).watchSingle();

  /// Get the current profile once (non-reactive).
  Future<PlayerProfile> getProfile() =>
      (select(playerProfiles)..where((t) => t.id.equals(1))).getSingle();

  /// Add coins to the player's balance.
  Future<void> addCoins(int amount) async {
    final profile = await getProfile();
    await (update(playerProfiles)..where((t) => t.id.equals(1))).write(
      PlayerProfilesCompanion(coins: Value(profile.coins + amount)),
    );
  }

  /// Add gems to the player's balance.
  Future<void> addGems(int amount) async {
    final profile = await getProfile();
    await (update(playerProfiles)..where((t) => t.id.equals(1))).write(
      PlayerProfilesCompanion(gems: Value(profile.gems + amount)),
    );
  }

  /// Add XP to the player's total.
  Future<void> addXp(int amount) async {
    final profile = await getProfile();
    await (update(playerProfiles)..where((t) => t.id.equals(1))).write(
      PlayerProfilesCompanion(xp: Value(profile.xp + amount)),
    );
  }

  /// Update user preference settings.
  /// Only non-null parameters are updated.
  Future<void> updateSettings({
    bool? colorblindMode,
    bool? soundOn,
    bool? hapticsOn,
  }) async {
    final companion = PlayerProfilesCompanion(
      colorblindMode:
          colorblindMode != null ? Value(colorblindMode) : const Value.absent(),
      soundOn: soundOn != null ? Value(soundOn) : const Value.absent(),
      hapticsOn: hapticsOn != null ? Value(hapticsOn) : const Value.absent(),
    );
    await (update(playerProfiles)..where((t) => t.id.equals(1)))
        .write(companion);
  }
}
