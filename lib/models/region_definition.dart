import 'package:freezed_annotation/freezed_annotation.dart';

import 'trigger_definition.dart';

part 'region_definition.freezed.dart';
part 'region_definition.g.dart';

/// Definition of a single colorable region within a level.
///
/// The [id] must match the encoded pixel value in the level's region mask
/// image (see §5 — ID-mask hit-testing). For example, region 14 is encoded
/// as RGB(0, 0, 14) in the mask image.
///
/// [targetColor] is the hex color the region should become when filled.
/// [paletteSlot] maps to the position in the player's color palette UI.
/// [onFillTriggers] define what happens when this region is filled (animations,
/// sounds, chain reactions).
@freezed
abstract class RegionDefinition with _$RegionDefinition {
  const factory RegionDefinition({
    required int id,
    required String targetColor,
    required int paletteSlot,
    @Default([]) List<TriggerDefinition> onFillTriggers,
  }) = _RegionDefinition;

  factory RegionDefinition.fromJson(Map<String, dynamic> json) =>
      _$RegionDefinitionFromJson(json);
}
