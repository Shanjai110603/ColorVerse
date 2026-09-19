// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'level_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LevelDefinition _$LevelDefinitionFromJson(Map<String, dynamic> json) =>
    _LevelDefinition(
      levelId: json['levelId'] as String,
      displayName: json['displayName'] as String,
      world: json['world'] as String,
      lineArt: json['lineArt'] as String,
      regionMask: json['regionMask'] as String,
      regionCount: (json['regionCount'] as num).toInt(),
      difficulty: json['difficulty'] as String,
      regions: (json['regions'] as List<dynamic>)
          .map((e) => RegionDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      hiddenEvents: (json['hiddenEvents'] as List<dynamic>)
          .map((e) => HiddenEventDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      completionRewards: RewardBundle.fromJson(
        json['completionRewards'] as Map<String, dynamic>,
      ),
      weatherSequence:
          (json['weatherSequence'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LevelDefinitionToJson(_LevelDefinition instance) =>
    <String, dynamic>{
      'levelId': instance.levelId,
      'displayName': instance.displayName,
      'world': instance.world,
      'lineArt': instance.lineArt,
      'regionMask': instance.regionMask,
      'regionCount': instance.regionCount,
      'difficulty': instance.difficulty,
      'regions': instance.regions.map((e) => e.toJson()).toList(),
      'hiddenEvents': instance.hiddenEvents.map((e) => e.toJson()).toList(),
      'completionRewards': instance.completionRewards.toJson(),
      'weatherSequence': instance.weatherSequence,
    };
