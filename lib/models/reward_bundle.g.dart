// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'reward_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardBundle _$RewardBundleFromJson(Map<String, dynamic> json) =>
    _RewardBundle(
      coins: (json['coins'] as num?)?.toInt() ?? 0,
      gems: (json['gems'] as num?)?.toInt() ?? 0,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      wood: (json['wood'] as num?)?.toInt() ?? 0,
      stone: (json['stone'] as num?)?.toInt() ?? 0,
      crystal: (json['crystal'] as num?)?.toInt() ?? 0,
      food: (json['food'] as num?)?.toInt() ?? 0,
      gold: (json['gold'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RewardBundleToJson(_RewardBundle instance) =>
    <String, dynamic>{
      'coins': instance.coins,
      'gems': instance.gems,
      'xp': instance.xp,
      'wood': instance.wood,
      'stone': instance.stone,
      'crystal': instance.crystal,
      'food': instance.food,
      'gold': instance.gold,
    };
