import 'dart:math' as math;

import '../models/models.dart';
import '../storage/daos/island_resources_dao.dart';
import '../storage/daos/player_profile_dao.dart';

/// Stateless controller for player leveling, level unlocking, and reward granting.
class ProgressionController {
  ProgressionController._();

  /// Calculate player level from accumulated XP.
  /// Level 1 starts at 0 XP. Leveling formula: level = floor(sqrt(xp / 10)) + 1.
  static int calculatePlayerLevel(int xp) {
    if (xp <= 0) return 1;
    return math.sqrt(xp / 10.0).floor() + 1;
  }

  /// Calculate progress percentage toward next level (0.0 to 1.0).
  static double calculateLevelProgress(int xp) {
    final currentLevel = calculatePlayerLevel(xp);
    final xpForCurrent = (currentLevel - 1) * (currentLevel - 1) * 10;
    final xpForNext = currentLevel * currentLevel * 10;

    final range = xpForNext - xpForCurrent;
    if (range <= 0) return 0.0;
    return ((xp - xpForCurrent) / range).clamp(0.0, 1.0);
  }

  /// Check if a level is unlocked for the player.
  static bool isLevelUnlocked({
    required LevelManifestEntry level,
    required int playerXp,
    required Set<String> completedLevelIds,
  }) {
    // 1. Check XP requirement
    if (playerXp < level.requiredXp) return false;

    // 2. Check prerequisite level completion requirement
    if (level.requiredLevelId != null &&
        !completedLevelIds.contains(level.requiredLevelId)) {
      return false;
    }

    return true;
  }

  /// Compute star rating based on completion percentage.
  /// 100% = 3 stars, >= 80% = 2 stars, > 0% = 1 star.
  static int calculateStarRating(int filledCount, int totalCount) {
    if (totalCount <= 0) return 3;
    final ratio = filledCount / totalCount;
    if (ratio >= 1.0) return 3;
    if (ratio >= 0.8) return 2;
    return 1;
  }

  /// Grant level completion rewards to player profile & island resources DAOs.
  static Future<void> grantRewards({
    required RewardBundle rewards,
    required PlayerProfileDao profileDao,
    required IslandResourcesDao resourcesDao,
  }) async {
    // Grant currencies & XP
    if (rewards.coins > 0) await profileDao.addCoins(rewards.coins);
    if (rewards.gems > 0) await profileDao.addGems(rewards.gems);
    if (rewards.xp > 0) await profileDao.addXp(rewards.xp);

    // Grant island builder resources
    if (rewards.wood > 0 ||
        rewards.stone > 0 ||
        rewards.crystal > 0 ||
        rewards.food > 0 ||
        rewards.gold > 0) {
      await resourcesDao.addResources(
        wood: rewards.wood,
        stone: rewards.stone,
        crystal: rewards.crystal,
        food: rewards.food,
        gold: rewards.gold,
      );
    }
  }
}
