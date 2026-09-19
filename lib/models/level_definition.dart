import 'package:freezed_annotation/freezed_annotation.dart';

import 'hidden_event_definition.dart';
import 'region_definition.dart';
import 'reward_bundle.dart';

part 'level_definition.freezed.dart';
part 'level_definition.g.dart';

/// Complete definition of a single level, produced by the authoring tool
/// and consumed at runtime.
///
/// Each level consists of:
/// - Two same-dimension images: visible line-art and hidden ID mask (§5)
/// - A list of [RegionDefinition]s defining each colorable region
/// - A list of [HiddenEventDefinition]s for conditional reveals
/// - Completion rewards and optional weather sequence
///
/// This model directly corresponds to the level.json schema in §3.1.
@freezed
abstract class LevelDefinition with _$LevelDefinition {
  const factory LevelDefinition({
    required String levelId,
    required String displayName,
    required String world,
    required String lineArt,
    required String regionMask,
    required int regionCount,
    required String difficulty,
    required List<RegionDefinition> regions,
    required List<HiddenEventDefinition> hiddenEvents,
    required RewardBundle completionRewards,
    @Default([]) List<String> weatherSequence,
  }) = _LevelDefinition;

  factory LevelDefinition.fromJson(Map<String, dynamic> json) =>
      _$LevelDefinitionFromJson(json);
}
