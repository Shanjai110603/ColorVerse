


import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/models/models.dart';

/// Unit tests for the data model layer (§3.1).
///
/// Validates:
/// - JSON parsing from the sample level.json
/// - Round-trip serialization (fromJson → toJson → fromJson)
/// - Sealed class discrimination for triggers, conditions, and reveals
/// - Default values and optional fields
void main() {
  group('LevelDefinition', () {
    late Map<String, dynamic> sampleJson;
    late LevelDefinition level;

    setUp(() {
      // The sample JSON matching assets/sample_levels/forest_01/level.json
      sampleJson = {
        "levelId": "forest_01",
        "displayName": "Whispering Grove",
        "world": "forest",
        "lineArt": "forest_01_lineart.png",
        "regionMask": "forest_01_regionmask.png",
        "regionCount": 214,
        "difficulty": "easy",
        "regions": [
          {
            "id": 14,
            "targetColor": "#3B7A45",
            "paletteSlot": 3,
            "onFillTriggers": [
              {
                "type": "animation",
                "asset": "leaves_grow.riv",
                "anchor": "region_centroid"
              },
              {"type": "sfx", "asset": "leaf_rustle.ogg"},
              {"type": "chain", "targetRegionId": 22, "delayMs": 800}
            ]
          },
          {
            "id": 22,
            "targetColor": "#5CA86C",
            "paletteSlot": 4,
            "onFillTriggers": [
              {
                "type": "animation",
                "asset": "vine_spread.riv",
                "anchor": "region_centroid"
              },
              {"type": "chain", "targetRegionId": 31, "delayMs": 600}
            ]
          },
          {
            "id": 31,
            "targetColor": "#2D5A1E",
            "paletteSlot": 2,
            "onFillTriggers": [
              {"type": "sfx", "asset": "forest_chime.ogg"}
            ]
          }
        ],
        "hiddenEvents": [
          {
            "id": "fairy_reveal",
            "condition": {
              "type": "allRegionsFilled",
              "regionIds": [14, 22, 31]
            },
            "reveal": {
              "type": "spriteReveal",
              "asset": "hidden_fairy.riv",
              "position": [0.62, 0.31]
            }
          }
        ],
        "completionRewards": {"coins": 40, "gems": 0, "xp": 25},
        "weatherSequence": ["morning", "afternoon", "sunset"]
      };

      level = LevelDefinition.fromJson(sampleJson);
    });

    test('parses basic fields correctly', () {
      expect(level.levelId, 'forest_01');
      expect(level.displayName, 'Whispering Grove');
      expect(level.world, 'forest');
      expect(level.lineArt, 'forest_01_lineart.png');
      expect(level.regionMask, 'forest_01_regionmask.png');
      expect(level.regionCount, 214);
      expect(level.difficulty, 'easy');
    });

    test('parses regions correctly', () {
      expect(level.regions.length, 3);
      expect(level.regions[0].id, 14);
      expect(level.regions[0].targetColor, '#3B7A45');
      expect(level.regions[0].paletteSlot, 3);
      expect(level.regions[1].id, 22);
      expect(level.regions[2].id, 31);
    });

    test('parses weather sequence correctly', () {
      expect(level.weatherSequence, ['morning', 'afternoon', 'sunset']);
    });

    test('parses completion rewards correctly', () {
      expect(level.completionRewards.coins, 40);
      expect(level.completionRewards.gems, 0);
      expect(level.completionRewards.xp, 25);
      // Defaults for island resources
      expect(level.completionRewards.wood, 0);
      expect(level.completionRewards.stone, 0);
    });

    test('round-trip serialization preserves data', () {
      final json = level.toJson();
      final roundTripped = LevelDefinition.fromJson(json);
      expect(roundTripped.levelId, level.levelId);
      expect(roundTripped.displayName, level.displayName);
      expect(roundTripped.regions.length, level.regions.length);
      expect(roundTripped.hiddenEvents.length, level.hiddenEvents.length);
      expect(roundTripped.weatherSequence, level.weatherSequence);
    });

    test('handles missing optional weatherSequence gracefully', () {
      final jsonWithoutWeather = Map<String, dynamic>.from(sampleJson);
      jsonWithoutWeather.remove('weatherSequence');
      final parsed = LevelDefinition.fromJson(jsonWithoutWeather);
      expect(parsed.weatherSequence, isEmpty);
    });
  });

  group('TriggerDefinition sealed class', () {
    test('parses AnimationTrigger correctly', () {
      final json = {
        "type": "animation",
        "asset": "leaves_grow.riv",
        "anchor": "region_centroid"
      };
      final trigger = TriggerDefinition.fromJson(json);
      expect(trigger, isA<AnimationTrigger>());
      final anim = trigger as AnimationTrigger;
      expect(anim.asset, 'leaves_grow.riv');
      expect(anim.anchor, 'region_centroid');
    });

    test('parses SfxTrigger correctly', () {
      final json = {"type": "sfx", "asset": "leaf_rustle.ogg"};
      final trigger = TriggerDefinition.fromJson(json);
      expect(trigger, isA<SfxTrigger>());
      expect((trigger as SfxTrigger).asset, 'leaf_rustle.ogg');
    });

    test('parses ChainTrigger correctly', () {
      final json = {"type": "chain", "targetRegionId": 22, "delayMs": 800};
      final trigger = TriggerDefinition.fromJson(json);
      expect(trigger, isA<ChainTrigger>());
      final chain = trigger as ChainTrigger;
      expect(chain.targetRegionId, 22);
      expect(chain.delayMs, 800);
    });

    test('round-trips AnimationTrigger', () {
      const trigger = AnimationTrigger(
        asset: 'test.riv',
        anchor: 'center',
      );
      final json = trigger.toJson();
      final parsed = TriggerDefinition.fromJson(json);
      expect(parsed, isA<AnimationTrigger>());
      expect((parsed as AnimationTrigger).asset, 'test.riv');
    });
  });

  group('RegionDefinition', () {
    test('parses region with triggers', () {
      final json = {
        "id": 14,
        "targetColor": "#3B7A45",
        "paletteSlot": 3,
        "onFillTriggers": [
          {
            "type": "animation",
            "asset": "leaves_grow.riv",
            "anchor": "region_centroid"
          },
          {"type": "sfx", "asset": "leaf_rustle.ogg"},
          {"type": "chain", "targetRegionId": 22, "delayMs": 800}
        ]
      };
      final region = RegionDefinition.fromJson(json);
      expect(region.id, 14);
      expect(region.targetColor, '#3B7A45');
      expect(region.paletteSlot, 3);
      expect(region.onFillTriggers.length, 3);
      expect(region.onFillTriggers[0], isA<AnimationTrigger>());
      expect(region.onFillTriggers[1], isA<SfxTrigger>());
      expect(region.onFillTriggers[2], isA<ChainTrigger>());
    });

    test('parses region with empty triggers', () {
      final json = {
        "id": 45,
        "targetColor": "#8B4513",
        "paletteSlot": 6,
        "onFillTriggers": []
      };
      final region = RegionDefinition.fromJson(json);
      expect(region.id, 45);
      expect(region.onFillTriggers, isEmpty);
    });

    test('defaults to empty triggers when field is missing', () {
      final json = {
        "id": 99,
        "targetColor": "#FFFFFF",
        "paletteSlot": 1,
      };
      final region = RegionDefinition.fromJson(json);
      expect(region.onFillTriggers, isEmpty);
    });
  });

  group('HiddenEventDefinition', () {
    test('parses allRegionsFilled condition', () {
      final json = {
        "id": "fairy_reveal",
        "condition": {
          "type": "allRegionsFilled",
          "regionIds": [14, 22, 31]
        },
        "reveal": {
          "type": "spriteReveal",
          "asset": "hidden_fairy.riv",
          "position": [0.62, 0.31]
        }
      };
      final event = HiddenEventDefinition.fromJson(json);
      expect(event.id, 'fairy_reveal');
      expect(event.condition, isA<AllRegionsFilledCondition>());
      final cond = event.condition as AllRegionsFilledCondition;
      expect(cond.regionIds, [14, 22, 31]);
    });

    test('parses anyRegionFilled condition', () {
      final json = {
        "id": "test_event",
        "condition": {
          "type": "anyRegionFilled",
          "regionIds": [1, 2]
        },
        "reveal": {
          "type": "spriteReveal",
          "asset": "test.riv",
          "position": [0.5, 0.5]
        }
      };
      final event = HiddenEventDefinition.fromJson(json);
      expect(event.condition, isA<AnyRegionFilledCondition>());
    });

    test('parses regionFilledWithinTime condition', () {
      final json = {
        "id": "timed_event",
        "condition": {
          "type": "regionFilledWithinTime",
          "regionIds": [10, 20],
          "timeLimitMs": 5000
        },
        "reveal": {
          "type": "spriteReveal",
          "asset": "bonus.riv",
          "position": [0.1, 0.9]
        }
      };
      final event = HiddenEventDefinition.fromJson(json);
      expect(event.condition, isA<RegionFilledWithinTimeCondition>());
      final cond = event.condition as RegionFilledWithinTimeCondition;
      expect(cond.timeLimitMs, 5000);
      expect(cond.regionIds, [10, 20]);
    });

    test('parses spriteReveal correctly', () {
      final json = {
        "id": "test",
        "condition": {
          "type": "allRegionsFilled",
          "regionIds": [1]
        },
        "reveal": {
          "type": "spriteReveal",
          "asset": "fairy.riv",
          "position": [0.62, 0.31]
        }
      };
      final event = HiddenEventDefinition.fromJson(json);
      expect(event.reveal, isA<SpriteReveal>());
      final reveal = event.reveal as SpriteReveal;
      expect(reveal.asset, 'fairy.riv');
      expect(reveal.position, [0.62, 0.31]);
    });
  });

  group('RewardBundle', () {
    test('parses with all fields', () {
      final json = {
        "coins": 40,
        "gems": 5,
        "xp": 25,
        "wood": 10,
        "stone": 3,
        "crystal": 1,
        "food": 5,
        "gold": 2
      };
      final reward = RewardBundle.fromJson(json);
      expect(reward.coins, 40);
      expect(reward.gems, 5);
      expect(reward.xp, 25);
      expect(reward.wood, 10);
      expect(reward.stone, 3);
      expect(reward.crystal, 1);
      expect(reward.food, 5);
      expect(reward.gold, 2);
    });

    test('defaults to zero for missing fields', () {
      final json = {"coins": 40, "gems": 0, "xp": 25};
      final reward = RewardBundle.fromJson(json);
      expect(reward.wood, 0);
      expect(reward.stone, 0);
      expect(reward.crystal, 0);
      expect(reward.food, 0);
      expect(reward.gold, 0);
    });

    test('empty JSON produces all zeros', () {
      final reward = RewardBundle.fromJson({});
      expect(reward.coins, 0);
      expect(reward.gems, 0);
      expect(reward.xp, 0);
    });
  });
}
