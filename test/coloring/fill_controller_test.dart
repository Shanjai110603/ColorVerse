import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/coloring/fill_controller.dart';
import 'package:colorverse/models/models.dart';
import 'package:colorverse/rendering/fill_state.dart';

/// Build a minimal test level.
LevelDefinition _makeLevel({List<RegionDefinition>? regions}) {
  return LevelDefinition(
    levelId: 'test_level',
    displayName: 'Test Level',
    world: 'forest',
    lineArt: 'test_lineart.png',
    regionMask: 'test_mask.png',
    regionCount: regions?.length ?? 3,
    difficulty: 'easy',
    regions: regions ??
        [
          const RegionDefinition(
              id: 1, targetColor: '#FF0000', paletteSlot: 1),
          const RegionDefinition(
              id: 2, targetColor: '#00FF00', paletteSlot: 2),
          const RegionDefinition(
              id: 3, targetColor: '#0000FF', paletteSlot: 1),
        ],
    hiddenEvents: const [],
    completionRewards: const RewardBundle(coins: 10, xp: 5),
  );
}

void main() {
  group('FillController', () {
    late FillState fillState;
    late FillController controller;

    setUp(() {
      fillState = FillState();
      controller = FillController(
        level: _makeLevel(),
        fillState: fillState,
      );
    });

    test('successful fill returns success + triggers', () {
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
              TriggerDefinition.animation(
                  asset: 'anim.riv', anchor: 'centroid'),
            ],
          ),
        ],
        hiddenEvents: const [],
        completionRewards: const RewardBundle(),
      );
      final ctrl = FillController(
        level: level,
        fillState: FillState(),
      );

      final result = ctrl.processRegionTap(1, 1);

      expect(result.isSuccess, isTrue);
      expect(result.type, FillResultType.success);
      expect(result.triggers.length, 1);
    });

    test('filling marks region as filled in FillState', () {
      controller.processRegionTap(1, 1);

      expect(fillState.isFilled(1), isTrue);
      expect(fillState.getColor(1), isNotNull);
    });

    test('wrong palette slot returns wrongPalette', () {
      // Region 1 requires slot 1, selecting slot 2
      final result = controller.processRegionTap(1, 2);

      expect(result.type, FillResultType.wrongPalette);
      expect(result.isSuccess, isFalse);
      expect(fillState.isFilled(1), isFalse);
    });

    test('non-existent region ID returns invalidRegion', () {
      final result = controller.processRegionTap(99, 1);

      expect(result.type, FillResultType.invalidRegion);
      expect(result.isSuccess, isFalse);
    });

    test('already-filled region returns alreadyFilled', () {
      controller.processRegionTap(1, 1); // first fill
      final result = controller.processRegionTap(1, 1); // second fill

      expect(result.type, FillResultType.alreadyFilled);
      expect(result.isSuccess, isFalse);
    });

    test('isComplete is false until all regions filled', () {
      expect(controller.isComplete, isFalse);
      controller.processRegionTap(1, 1);
      expect(controller.isComplete, isFalse);
      controller.processRegionTap(3, 1); // slot 1 regions
      expect(controller.isComplete, isFalse);
      controller.processRegionTap(2, 2); // slot 2 region
      expect(controller.isComplete, isTrue);
    });

    test('paletteSlots returns all unique slots sorted', () {
      expect(controller.paletteSlots, [1, 2]);
    });

    test('getPaletteColor returns correct color for slot', () {
      final color = controller.getPaletteColor(1);
      expect(color, isNotNull);
      // Region 1 has targetColor #FF0000 = opaque red
      expect((color!.r * 255).round(), 255);
      expect((color.g * 255).round(), 0);
      expect((color.b * 255).round(), 0);
    });

    test('filledRegions and totalRegions update correctly', () {
      expect(controller.filledRegions, 0);
      expect(controller.totalRegions, 3);

      controller.processRegionTap(1, 1);
      expect(controller.filledRegions, 1);
    });
  });

  group('FillState', () {
    test('markFilled returns true for new fill', () {
      final state = FillState();
      expect(state.markFilled(1, const Color(0xFFFF0000)), isTrue);
    });

    test('markFilled returns false if already filled', () {
      final state = FillState();
      state.markFilled(1, const Color(0xFFFF0000));
      expect(state.markFilled(1, const Color(0xFFFF0000)), isFalse);
    });

    test('unfill removes a filled region', () {
      final state = FillState();
      state.markFilled(1, const Color(0xFFFF0000));
      expect(state.isFilled(1), isTrue);
      state.unfill(1);
      expect(state.isFilled(1), isFalse);
    });

    test('clear removes all fills', () {
      final state = FillState();
      state.markFilled(1, const Color(0xFFFF0000));
      state.markFilled(2, const Color(0xFF00FF00));
      state.clear();
      expect(state.filledCount, 0);
    });

    test('initial fills from constructor are set', () {
      final state = FillState(
        initialFilledIds: {1, 2},
        regionColors: {
          1: const Color(0xFFFF0000),
          2: const Color(0xFF00FF00),
        },
      );
      expect(state.isFilled(1), isTrue);
      expect(state.isFilled(2), isTrue);
      expect(state.filledCount, 2);
    });
  });
}
