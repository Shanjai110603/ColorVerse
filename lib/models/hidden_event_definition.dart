import 'package:freezed_annotation/freezed_annotation.dart';

part 'hidden_event_definition.freezed.dart';
part 'hidden_event_definition.g.dart';

/// Definition of a hidden event within a level.
///
/// Hidden events are triggered when their [condition] is satisfied
/// (e.g., all specified regions are filled). Each event fires exactly once
/// per level playthrough (tracked in save data to prevent replay).
@freezed
abstract class HiddenEventDefinition with _$HiddenEventDefinition {
  const factory HiddenEventDefinition({
    required String id,
    required EventCondition condition,
    required EventReveal reveal,
  }) = _HiddenEventDefinition;

  factory HiddenEventDefinition.fromJson(Map<String, dynamic> json) =>
      _$HiddenEventDefinitionFromJson(json);
}

/// Sealed class for event conditions.
///
/// Uses `"type"` as the JSON union discriminator to match the §3.1 schema.
/// Conditions are evaluated after every region fill event.
@Freezed(unionKey: 'type')
sealed class EventCondition with _$EventCondition {
  /// All specified regions must be filled to satisfy this condition.
  const factory EventCondition.allRegionsFilled({
    required List<int> regionIds,
  }) = AllRegionsFilledCondition;

  /// Any one of the specified regions being filled satisfies this condition.
  const factory EventCondition.anyRegionFilled({
    required List<int> regionIds,
  }) = AnyRegionFilledCondition;

  /// All specified regions must be filled within a time limit (in ms)
  /// from the first fill in the set.
  const factory EventCondition.regionFilledWithinTime({
    required List<int> regionIds,
    required int timeLimitMs,
  }) = RegionFilledWithinTimeCondition;

  factory EventCondition.fromJson(Map<String, dynamic> json) =>
      _$EventConditionFromJson(json);
}

/// Sealed class for event reveal actions — what happens when a hidden
/// event's condition is satisfied.
///
/// Uses `"type"` as the JSON union discriminator to match the §3.1 schema.
@Freezed(unionKey: 'type')
sealed class EventReveal with _$EventReveal {
  /// Reveals a hidden sprite/animation at a normalized position [0..1, 0..1].
  const factory EventReveal.spriteReveal({
    required String asset,
    required List<double> position,
  }) = SpriteReveal;

  factory EventReveal.fromJson(Map<String, dynamic> json) =>
      _$EventRevealFromJson(json);
}
