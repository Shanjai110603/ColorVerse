import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_bundle.freezed.dart';
part 'reward_bundle.g.dart';

/// Reward bundle awarded on level completion or from other game events.
/// Includes both primary currencies (coins, gems, XP) and island-builder
/// resources (wood, stone, crystal, food, gold).
@freezed
abstract class RewardBundle with _$RewardBundle {
  const factory RewardBundle({
    @Default(0) int coins,
    @Default(0) int gems,
    @Default(0) int xp,
    @Default(0) int wood,
    @Default(0) int stone,
    @Default(0) int crystal,
    @Default(0) int food,
    @Default(0) int gold,
  }) = _RewardBundle;

  factory RewardBundle.fromJson(Map<String, dynamic> json) =>
      _$RewardBundleFromJson(json);
}
