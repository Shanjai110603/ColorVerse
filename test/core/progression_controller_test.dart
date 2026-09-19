import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/core/progression_controller.dart';
import 'package:colorverse/models/models.dart';

void main() {
  group('ProgressionController', () {
    test('calculatePlayerLevel correctly calculates level thresholds', () {
      expect(ProgressionController.calculatePlayerLevel(0), 1);
      expect(ProgressionController.calculatePlayerLevel(5), 1);
      expect(ProgressionController.calculatePlayerLevel(10), 2);
      expect(ProgressionController.calculatePlayerLevel(40), 3);
      expect(ProgressionController.calculatePlayerLevel(90), 4);
    });

    test('calculateLevelProgress returns normalized float in 0..1 range', () {
      expect(ProgressionController.calculateLevelProgress(0), 0.0);
      expect(ProgressionController.calculateLevelProgress(10), 0.0);
      final progressMid = ProgressionController.calculateLevelProgress(25);
      expect(progressMid, greaterThan(0.0));
      expect(progressMid, lessThan(1.0));
    });

    test('isLevelUnlocked enforces XP requirement and prerequisite levels', () {
      const entryNoReq = LevelManifestEntry(
        levelId: 'l1',
        displayName: 'Level 1',
        world: 'forest',
        difficulty: 'easy',
        regionCount: 100,
        requiredXp: 0,
      );

      const entryXpReq = LevelManifestEntry(
        levelId: 'l2',
        displayName: 'Level 2',
        world: 'forest',
        difficulty: 'medium',
        regionCount: 150,
        requiredXp: 50,
      );

      const entryPrereq = LevelManifestEntry(
        levelId: 'l3',
        displayName: 'Level 3',
        world: 'forest',
        difficulty: 'hard',
        regionCount: 200,
        requiredXp: 0,
        requiredLevelId: 'l1',
      );

      expect(
        ProgressionController.isLevelUnlocked(
          level: entryNoReq,
          playerXp: 0,
          completedLevelIds: {},
        ),
        isTrue,
      );

      expect(
        ProgressionController.isLevelUnlocked(
          level: entryXpReq,
          playerXp: 20,
          completedLevelIds: {},
        ),
        isFalse,
      );

      expect(
        ProgressionController.isLevelUnlocked(
          level: entryXpReq,
          playerXp: 50,
          completedLevelIds: {},
        ),
        isTrue,
      );

      expect(
        ProgressionController.isLevelUnlocked(
          level: entryPrereq,
          playerXp: 100,
          completedLevelIds: {},
        ),
        isFalse,
      );

      expect(
        ProgressionController.isLevelUnlocked(
          level: entryPrereq,
          playerXp: 100,
          completedLevelIds: {'l1'},
        ),
        isTrue,
      );
    });

    test('calculateStarRating returns expected rating per fill ratio', () {
      expect(ProgressionController.calculateStarRating(100, 100), 3);
      expect(ProgressionController.calculateStarRating(85, 100), 2);
      expect(ProgressionController.calculateStarRating(50, 100), 1);
    });
  });
}
