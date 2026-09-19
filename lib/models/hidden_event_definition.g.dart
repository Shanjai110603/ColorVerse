// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'hidden_event_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HiddenEventDefinition _$HiddenEventDefinitionFromJson(
  Map<String, dynamic> json,
) => _HiddenEventDefinition(
  id: json['id'] as String,
  condition: EventCondition.fromJson(json['condition'] as Map<String, dynamic>),
  reveal: EventReveal.fromJson(json['reveal'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HiddenEventDefinitionToJson(
  _HiddenEventDefinition instance,
) => <String, dynamic>{
  'id': instance.id,
  'condition': instance.condition.toJson(),
  'reveal': instance.reveal.toJson(),
};

AllRegionsFilledCondition _$AllRegionsFilledConditionFromJson(
  Map<String, dynamic> json,
) => AllRegionsFilledCondition(
  regionIds: (json['regionIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AllRegionsFilledConditionToJson(
  AllRegionsFilledCondition instance,
) => <String, dynamic>{'regionIds': instance.regionIds, 'type': instance.$type};

AnyRegionFilledCondition _$AnyRegionFilledConditionFromJson(
  Map<String, dynamic> json,
) => AnyRegionFilledCondition(
  regionIds: (json['regionIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AnyRegionFilledConditionToJson(
  AnyRegionFilledCondition instance,
) => <String, dynamic>{'regionIds': instance.regionIds, 'type': instance.$type};

RegionFilledWithinTimeCondition _$RegionFilledWithinTimeConditionFromJson(
  Map<String, dynamic> json,
) => RegionFilledWithinTimeCondition(
  regionIds: (json['regionIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  timeLimitMs: (json['timeLimitMs'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RegionFilledWithinTimeConditionToJson(
  RegionFilledWithinTimeCondition instance,
) => <String, dynamic>{
  'regionIds': instance.regionIds,
  'timeLimitMs': instance.timeLimitMs,
  'type': instance.$type,
};

SpriteReveal _$SpriteRevealFromJson(Map<String, dynamic> json) => SpriteReveal(
  asset: json['asset'] as String,
  position: (json['position'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$SpriteRevealToJson(SpriteReveal instance) =>
    <String, dynamic>{'asset': instance.asset, 'position': instance.position};
