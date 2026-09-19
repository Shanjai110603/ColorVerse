import 'package:freezed_annotation/freezed_annotation.dart';

part 'trigger_definition.freezed.dart';
part 'trigger_definition.g.dart';

/// Sealed class hierarchy for region fill triggers.
///
/// Each region can have zero or more triggers that fire when it is filled:
/// - [AnimationTrigger] — plays a Rive/Lottie animation at the region's anchor
/// - [SfxTrigger] — plays a sound effect
/// - [ChainTrigger] — schedules a delayed auto-fill of another region
///
/// Uses `"type"` as the JSON union discriminator to match the §3.1 schema.
@Freezed(unionKey: 'type')
sealed class TriggerDefinition with _$TriggerDefinition {
  /// Plays an animation (Rive or Lottie) at a specified anchor point.
  const factory TriggerDefinition.animation({
    required String asset,
    required String anchor,
  }) = AnimationTrigger;

  /// Plays a one-shot sound effect.
  const factory TriggerDefinition.sfx({
    required String asset,
  }) = SfxTrigger;

  /// Chains into another region's fill after a delay.
  /// The target region will be auto-filled [delayMs] milliseconds later,
  /// unless it's already filled or doesn't exist (guarded at runtime).
  const factory TriggerDefinition.chain({
    required int targetRegionId,
    required int delayMs,
  }) = ChainTrigger;

  factory TriggerDefinition.fromJson(Map<String, dynamic> json) =>
      _$TriggerDefinitionFromJson(json);
}
