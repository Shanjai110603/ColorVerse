import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:colorverse/models/models.dart';

import 'package:level_editor/editor/level_exporter.dart';
import 'package:level_editor/editor/region_detector.dart';

/// Helper to create a minimal list of DetectedRegions for testing.
List<DetectedRegion> _makeRegions(List<int> ids) {
  return ids.map((id) {
    return DetectedRegion(
      assignedId: id,
      originalColorKey: id * 1000,
      pixels: [Point(id, id)],
      centroid: Offset(id.toDouble(), id.toDouble()),
      boundingBox: Rect.fromLTWH(
        id.toDouble(), id.toDouble(), 1, 1,
      ),
    );
  }).toList();
}

void main() {
  group('LevelExporter.validate', () {
    test('accepts valid level definition', () {
      final regions = _makeRegions([1, 2, 3]);
      final level = LevelDefinition(
        levelId: 'test_01',
        displayName: 'Test Level',
        world: 'forest',
        lineArt: 'test_lineart.png',
        regionMask: 'test_regionmask.png',
        regionCount: 3,
        difficulty: 'easy',
        regions: [
          const RegionDefinition(
            id: 1,
            targetColor: '#FF0000',
            paletteSlot: 1,
            onFillTriggers: [
              TriggerDefinition.animation(
                asset: 'anim.riv',
                anchor: 'region_centroid',
              ),
              TriggerDefinition.chain(targetRegionId: 2, delayMs: 500),
            ],
          ),
          const RegionDefinition(
            id: 2,
            targetColor: '#00FF00',
            paletteSlot: 2,
          ),
          const RegionDefinition(
            id: 3,
            targetColor: '#0000FF',
            paletteSlot: 3,
          ),
        ],
        hiddenEvents: [
          const HiddenEventDefinition(
            id: 'reveal_1',
            condition: EventCondition.allRegionsFilled(regionIds: [1, 2]),
            reveal: EventReveal.spriteReveal(
              asset: 'hidden.riv',
              position: [0.5, 0.5],
            ),
          ),
        ],
        completionRewards: const RewardBundle(coins: 10, xp: 5),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isEmpty);
    });

    test('detects non-existent region ID in level definition', () {
      final regions = _makeRegions([1, 2]);
      final level = LevelDefinition(
        levelId: 'test',
        displayName: 'Test',
        world: 'forest',
        lineArt: 'l.png',
        regionMask: 'm.png',
        regionCount: 1,
        difficulty: 'easy',
        regions: [
          const RegionDefinition(
            id: 99, // doesn't exist!
            targetColor: '#FF0000',
            paletteSlot: 1,
          ),
        ],
        hiddenEvents: const [],
        completionRewards: const RewardBundle(),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('99'));
    });

    test('detects chain trigger to non-existent region', () {
      final regions = _makeRegions([1, 2]);
      final level = LevelDefinition(
        levelId: 'test',
        displayName: 'Test',
        world: 'forest',
        lineArt: 'l.png',
        regionMask: 'm.png',
        regionCount: 2,
        difficulty: 'easy',
        regions: [
          const RegionDefinition(
            id: 1,
            targetColor: '#FF0000',
            paletteSlot: 1,
            onFillTriggers: [
              TriggerDefinition.chain(
                targetRegionId: 999, // doesn't exist!
                delayMs: 500,
              ),
            ],
          ),
        ],
        hiddenEvents: const [],
        completionRewards: const RewardBundle(),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isNotEmpty);
      expect(errors.any((e) => e.contains('999')), isTrue);
    });

    test('detects self-referencing chain trigger', () {
      final regions = _makeRegions([1]);
      final level = LevelDefinition(
        levelId: 'test',
        displayName: 'Test',
        world: 'forest',
        lineArt: 'l.png',
        regionMask: 'm.png',
        regionCount: 1,
        difficulty: 'easy',
        regions: [
          const RegionDefinition(
            id: 1,
            targetColor: '#FF0000',
            paletteSlot: 1,
            onFillTriggers: [
              TriggerDefinition.chain(targetRegionId: 1, delayMs: 500),
            ],
          ),
        ],
        hiddenEvents: const [],
        completionRewards: const RewardBundle(),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isNotEmpty);
      expect(errors.any((e) => e.contains('itself')), isTrue);
    });

    test('detects empty animation asset path', () {
      final regions = _makeRegions([1]);
      final level = LevelDefinition(
        levelId: 'test',
        displayName: 'Test',
        world: 'forest',
        lineArt: 'l.png',
        regionMask: 'm.png',
        regionCount: 1,
        difficulty: 'easy',
        regions: [
          const RegionDefinition(
            id: 1,
            targetColor: '#FF0000',
            paletteSlot: 1,
            onFillTriggers: [
              TriggerDefinition.animation(asset: '', anchor: 'centroid'),
            ],
          ),
        ],
        hiddenEvents: const [],
        completionRewards: const RewardBundle(),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isNotEmpty);
      expect(errors.any((e) => e.contains('empty asset')), isTrue);
    });

    test('detects hidden event referencing non-existent region', () {
      final regions = _makeRegions([1, 2]);
      final level = LevelDefinition(
        levelId: 'test',
        displayName: 'Test',
        world: 'forest',
        lineArt: 'l.png',
        regionMask: 'm.png',
        regionCount: 2,
        difficulty: 'easy',
        regions: const [],
        hiddenEvents: [
          const HiddenEventDefinition(
            id: 'event_1',
            condition: EventCondition.allRegionsFilled(
              regionIds: [1, 2, 42], // 42 doesn't exist!
            ),
            reveal: EventReveal.spriteReveal(
              asset: 'sprite.riv',
              position: [0.5, 0.5],
            ),
          ),
        ],
        completionRewards: const RewardBundle(),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isNotEmpty);
      expect(errors.any((e) => e.contains('42')), isTrue);
    });

    test('detects duplicate region IDs', () {
      final regions = _makeRegions([1, 2]);
      final level = LevelDefinition(
        levelId: 'test',
        displayName: 'Test',
        world: 'forest',
        lineArt: 'l.png',
        regionMask: 'm.png',
        regionCount: 2,
        difficulty: 'easy',
        regions: [
          const RegionDefinition(
            id: 1,
            targetColor: '#FF0000',
            paletteSlot: 1,
          ),
          const RegionDefinition(
            id: 1, // duplicate!
            targetColor: '#00FF00',
            paletteSlot: 2,
          ),
        ],
        hiddenEvents: const [],
        completionRewards: const RewardBundle(),
      );

      final errors = LevelExporter.validate(level, regions);
      expect(errors, isNotEmpty);
      expect(errors.any((e) => e.contains('Duplicate')), isTrue);
    });
  });
}
