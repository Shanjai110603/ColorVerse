// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'region_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionDefinition _$RegionDefinitionFromJson(Map<String, dynamic> json) =>
    _RegionDefinition(
      id: (json['id'] as num).toInt(),
      targetColor: json['targetColor'] as String,
      paletteSlot: (json['paletteSlot'] as num).toInt(),
      onFillTriggers:
          (json['onFillTriggers'] as List<dynamic>?)
              ?.map(
                (e) => TriggerDefinition.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RegionDefinitionToJson(_RegionDefinition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'targetColor': instance.targetColor,
      'paletteSlot': instance.paletteSlot,
      'onFillTriggers': instance.onFillTriggers.map((e) => e.toJson()).toList(),
    };
