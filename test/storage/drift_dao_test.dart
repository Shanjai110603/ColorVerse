import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/storage/database.dart';

/// Unit tests for the Drift storage layer (§3.2).
///
/// Uses in-memory SQLite database (NativeDatabase.memory()) for fast,
/// no-disk tests. Validates:
/// - Default seeding (profile + island resources)
/// - PlayerProfileDao: currency mutations, reactive streams
/// - LevelProgressDao: incremental fill saving, completion, reset
/// - CompanionDao: register, unlock, evolve
/// - IslandResourcesDao: add/spend resources
/// - EntitlementDao: purchase recording, activation state
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('PlayerProfileDao', () {
    test('seeds default profile on creation', () async {
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.id, 1);
      expect(profile.coins, 0);
      expect(profile.gems, 0);
      expect(profile.xp, 0);
      expect(profile.colorblindMode, false);
      expect(profile.soundOn, true);
      expect(profile.hapticsOn, true);
    });

    test('addCoins increases balance', () async {
      await db.playerProfileDao.addCoins(50);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.coins, 50);
    });

    test('addGems increases balance', () async {
      await db.playerProfileDao.addGems(10);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.gems, 10);
    });

    test('addXp increases total', () async {
      await db.playerProfileDao.addXp(100);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.xp, 100);
    });

    test('multiple addCoins calls accumulate', () async {
      await db.playerProfileDao.addCoins(10);
      await db.playerProfileDao.addCoins(20);
      await db.playerProfileDao.addCoins(30);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.coins, 60);
    });

    test('addCoins with negative amount decreases balance', () async {
      await db.playerProfileDao.addCoins(100);
      await db.playerProfileDao.addCoins(-30);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.coins, 70);
    });

    test('updateSettings changes colorblindMode', () async {
      await db.playerProfileDao.updateSettings(colorblindMode: true);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.colorblindMode, true);
      expect(profile.soundOn, true); // unchanged
    });

    test('updateSettings changes soundOn without affecting other settings',
        () async {
      await db.playerProfileDao.updateSettings(soundOn: false);
      final profile = await db.playerProfileDao.getProfile();
      expect(profile.soundOn, false);
      expect(profile.hapticsOn, true); // unchanged
    });

    test('watchProfile emits updated values', () async {
      final stream = db.playerProfileDao.watchProfile();

      // Expect initial value, then updated after addCoins
      expectLater(
        stream.map((p) => p.coins),
        emitsInOrder([0, 42]),
      );

      // Give the stream time to set up, then mutate
      await Future.delayed(const Duration(milliseconds: 50));
      await db.playerProfileDao.addCoins(42);
    });
  });

  group('LevelProgressDao', () {
    test('getLevel returns null for non-existent level', () async {
      final result = await db.levelProgressDao.getLevel('nonexistent');
      expect(result, isNull);
    });

    test('ensureExists creates entry with default state', () async {
      await db.levelProgressDao.ensureExists('test_level');
      final entry = await db.levelProgressDao.getLevel('test_level');
      expect(entry, isNotNull);
      expect(entry!.status, 'not_started');
      expect(entry.filledRegionIds, '[]');
      expect(entry.completedAt, isNull);
      expect(entry.starRating, isNull);
    });

    test('markRegionFilled adds region and sets in_progress', () async {
      await db.levelProgressDao.markRegionFilled('forest_01', 14);
      final entry = await db.levelProgressDao.getLevel('forest_01');
      expect(entry!.status, 'in_progress');
      final ids = jsonDecode(entry.filledRegionIds) as List;
      expect(ids, [14]);
    });

    test('markRegionFilled accumulates incrementally', () async {
      await db.levelProgressDao.markRegionFilled('forest_01', 14);
      await db.levelProgressDao.markRegionFilled('forest_01', 22);
      await db.levelProgressDao.markRegionFilled('forest_01', 31);

      final ids = await db.levelProgressDao.getFilledRegionIds('forest_01');
      expect(ids, [14, 22, 31]);
    });

    test('markRegionFilled is idempotent (no duplicates)', () async {
      await db.levelProgressDao.markRegionFilled('forest_01', 14);
      await db.levelProgressDao.markRegionFilled('forest_01', 14);

      final ids = await db.levelProgressDao.getFilledRegionIds('forest_01');
      expect(ids, [14]); // not [14, 14]
    });

    test('markCompleted sets status, time, and star rating', () async {
      await db.levelProgressDao.markRegionFilled('forest_01', 14);
      await db.levelProgressDao.markCompleted('forest_01', 3);

      final entry = await db.levelProgressDao.getLevel('forest_01');
      expect(entry!.status, 'completed');
      expect(entry.starRating, 3);
      expect(entry.completedAt, isNotNull);
    });

    test('resetLevel clears all progress', () async {
      await db.levelProgressDao.markRegionFilled('forest_01', 14);
      await db.levelProgressDao.markRegionFilled('forest_01', 22);
      await db.levelProgressDao.markCompleted('forest_01', 2);
      await db.levelProgressDao.resetLevel('forest_01');

      final entry = await db.levelProgressDao.getLevel('forest_01');
      expect(entry!.status, 'not_started');
      expect(entry.filledRegionIds, '[]');
      expect(entry.completedAt, isNull);
      expect(entry.starRating, isNull);
    });

    test('getFilledRegionIds returns empty list for non-existent level',
        () async {
      final ids = await db.levelProgressDao.getFilledRegionIds('nonexistent');
      expect(ids, isEmpty);
    });

    test('watchLevel emits updates on region fill', () async {
      await db.levelProgressDao.ensureExists('forest_01');

      final stream = db.levelProgressDao.watchLevel('forest_01');

      expectLater(
        stream.map((e) => e?.status),
        emitsInOrder(['not_started', 'in_progress']),
      );

      await Future.delayed(const Duration(milliseconds: 50));
      await db.levelProgressDao.markRegionFilled('forest_01', 14);
    });
  });

  group('CompanionDao', () {
    test('registerCompanion creates locked companion', () async {
      await db.companionDao.registerCompanion('fox_01');
      final companion = await db.companionDao.getCompanion('fox_01');
      expect(companion, isNotNull);
      expect(companion!.unlocked, false);
      expect(companion.evolutionStage, 0);
    });

    test('unlockCompanion sets unlocked to true', () async {
      await db.companionDao.registerCompanion('fox_01');
      await db.companionDao.unlockCompanion('fox_01');
      final companion = await db.companionDao.getCompanion('fox_01');
      expect(companion!.unlocked, true);
    });

    test('evolveCompanion increments evolution stage', () async {
      await db.companionDao.registerCompanion('fox_01');
      await db.companionDao.evolveCompanion('fox_01');
      await db.companionDao.evolveCompanion('fox_01');
      final companion = await db.companionDao.getCompanion('fox_01');
      expect(companion!.evolutionStage, 2);
    });

    test('watchUnlocked only returns unlocked companions', () async {
      await db.companionDao.registerCompanion('fox_01');
      await db.companionDao.registerCompanion('owl_01');
      await db.companionDao.unlockCompanion('fox_01');

      final unlocked = await db.companionDao.watchUnlocked().first;
      expect(unlocked.length, 1);
      expect(unlocked.first.id, 'fox_01');
    });
  });

  group('IslandResourcesDao', () {
    test('seeds default resources on creation', () async {
      final res = await db.islandResourcesDao.getResources();
      expect(res.wood, 0);
      expect(res.stone, 0);
      expect(res.crystal, 0);
      expect(res.food, 0);
      expect(res.gold, 0);
    });

    test('addResources increases totals', () async {
      await db.islandResourcesDao
          .addResources(wood: 10, stone: 5, food: 3);
      final res = await db.islandResourcesDao.getResources();
      expect(res.wood, 10);
      expect(res.stone, 5);
      expect(res.food, 3);
      expect(res.crystal, 0); // unchanged
    });

    test('spendResources succeeds when sufficient', () async {
      await db.islandResourcesDao.addResources(wood: 20, stone: 10);
      final success =
          await db.islandResourcesDao.spendResources(wood: 5, stone: 3);
      expect(success, true);
      final res = await db.islandResourcesDao.getResources();
      expect(res.wood, 15);
      expect(res.stone, 7);
    });

    test('spendResources fails when insufficient', () async {
      await db.islandResourcesDao.addResources(wood: 5);
      final success = await db.islandResourcesDao.spendResources(wood: 10);
      expect(success, false);
      // Balance unchanged
      final res = await db.islandResourcesDao.getResources();
      expect(res.wood, 5);
    });
  });

  group('EntitlementDao', () {
    test('isActive returns false for non-existent SKU', () async {
      final active = await db.entitlementDao.isActive('nonexistent');
      expect(active, false);
    });

    test('recordPurchase creates active entitlement', () async {
      await db.entitlementDao.recordPurchase('remove_ads');
      final active = await db.entitlementDao.isActive('remove_ads');
      expect(active, true);
    });

    test('deactivate sets active to false', () async {
      await db.entitlementDao.recordPurchase('premium_pack');
      await db.entitlementDao.deactivate('premium_pack');
      final active = await db.entitlementDao.isActive('premium_pack');
      expect(active, false);
    });

    test('reactivate sets active back to true', () async {
      await db.entitlementDao.recordPurchase('subscription');
      await db.entitlementDao.deactivate('subscription');
      await db.entitlementDao.reactivate('subscription');
      final active = await db.entitlementDao.isActive('subscription');
      expect(active, true);
    });

    test('watchAll emits updated list', () async {
      final stream = db.entitlementDao.watchAll();

      expectLater(
        stream.map((list) => list.length),
        emitsInOrder([0, 1]),
      );

      await Future.delayed(const Duration(milliseconds: 50));
      await db.entitlementDao.recordPurchase('test_sku');
    });
  });
}
