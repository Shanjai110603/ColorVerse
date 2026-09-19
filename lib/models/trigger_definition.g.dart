// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'trigger_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimationTrigger _$AnimationTriggerFromJson(Map<String, dynamic> json) =>
    AnimationTrigger(
      asset: json['asset'] as String,
      anchor: json['anchor'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$AnimationTriggerToJson(AnimationTrigger instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'anchor': instance.anchor,
      'type': instance.$type,
    };

SfxTrigger _$SfxTriggerFromJson(Map<String, dynamic> json) =>
    SfxTrigger(asset: json['asset'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$SfxTriggerToJson(SfxTrigger instance) =>
    <String, dynamic>{'asset': instance.asset, 'type': instance.$type};

ChainTrigger _$ChainTriggerFromJson(Map<String, dynamic> json) => ChainTrigger(
  targetRegionId: (json['targetRegionId'] as num).toInt(),
  delayMs: (json['delayMs'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ChainTriggerToJson(ChainTrigger instance) =>
    <String, dynamic>{
      'targetRegionId': instance.targetRegionId,
      'delayMs': instance.delayMs,
      'type': instance.$type,
    };
