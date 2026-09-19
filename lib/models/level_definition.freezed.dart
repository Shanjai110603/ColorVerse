// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LevelDefinition {

 String get levelId; String get displayName; String get world; String get lineArt; String get regionMask; int get regionCount; String get difficulty; List<RegionDefinition> get regions; List<HiddenEventDefinition> get hiddenEvents; RewardBundle get completionRewards; List<String> get weatherSequence;
/// Create a copy of LevelDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelDefinitionCopyWith<LevelDefinition> get copyWith => _$LevelDefinitionCopyWithImpl<LevelDefinition>(this as LevelDefinition, _$identity);

  /// Serializes this LevelDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelDefinition&&(identical(other.levelId, levelId) || other.levelId == levelId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.world, world) || other.world == world)&&(identical(other.lineArt, lineArt) || other.lineArt == lineArt)&&(identical(other.regionMask, regionMask) || other.regionMask == regionMask)&&(identical(other.regionCount, regionCount) || other.regionCount == regionCount)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.hiddenEvents, hiddenEvents)&&(identical(other.completionRewards, completionRewards) || other.completionRewards == completionRewards)&&const DeepCollectionEquality().equals(other.weatherSequence, weatherSequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,levelId,displayName,world,lineArt,regionMask,regionCount,difficulty,const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(hiddenEvents),completionRewards,const DeepCollectionEquality().hash(weatherSequence));

@override
String toString() {
  return 'LevelDefinition(levelId: $levelId, displayName: $displayName, world: $world, lineArt: $lineArt, regionMask: $regionMask, regionCount: $regionCount, difficulty: $difficulty, regions: $regions, hiddenEvents: $hiddenEvents, completionRewards: $completionRewards, weatherSequence: $weatherSequence)';
}


}

/// @nodoc
abstract mixin class $LevelDefinitionCopyWith<$Res>  {
  factory $LevelDefinitionCopyWith(LevelDefinition value, $Res Function(LevelDefinition) _then) = _$LevelDefinitionCopyWithImpl;
@useResult
$Res call({
 String levelId, String displayName, String world, String lineArt, String regionMask, int regionCount, String difficulty, List<RegionDefinition> regions, List<HiddenEventDefinition> hiddenEvents, RewardBundle completionRewards, List<String> weatherSequence
});


$RewardBundleCopyWith<$Res> get completionRewards;

}
/// @nodoc
class _$LevelDefinitionCopyWithImpl<$Res>
    implements $LevelDefinitionCopyWith<$Res> {
  _$LevelDefinitionCopyWithImpl(this._self, this._then);

  final LevelDefinition _self;
  final $Res Function(LevelDefinition) _then;

/// Create a copy of LevelDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? levelId = null,Object? displayName = null,Object? world = null,Object? lineArt = null,Object? regionMask = null,Object? regionCount = null,Object? difficulty = null,Object? regions = null,Object? hiddenEvents = null,Object? completionRewards = null,Object? weatherSequence = null,}) {
  return _then(_self.copyWith(
levelId: null == levelId ? _self.levelId : levelId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,world: null == world ? _self.world : world // ignore: cast_nullable_to_non_nullable
as String,lineArt: null == lineArt ? _self.lineArt : lineArt // ignore: cast_nullable_to_non_nullable
as String,regionMask: null == regionMask ? _self.regionMask : regionMask // ignore: cast_nullable_to_non_nullable
as String,regionCount: null == regionCount ? _self.regionCount : regionCount // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<RegionDefinition>,hiddenEvents: null == hiddenEvents ? _self.hiddenEvents : hiddenEvents // ignore: cast_nullable_to_non_nullable
as List<HiddenEventDefinition>,completionRewards: null == completionRewards ? _self.completionRewards : completionRewards // ignore: cast_nullable_to_non_nullable
as RewardBundle,weatherSequence: null == weatherSequence ? _self.weatherSequence : weatherSequence // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of LevelDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardBundleCopyWith<$Res> get completionRewards {
  
  return $RewardBundleCopyWith<$Res>(_self.completionRewards, (value) {
    return _then(_self.copyWith(completionRewards: value));
  });
}
}


/// Adds pattern-matching-related methods to [LevelDefinition].
extension LevelDefinitionPatterns on LevelDefinition {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelDefinition() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelDefinition value)  $default,){
final _that = this;
switch (_that) {
case _LevelDefinition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _LevelDefinition() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String levelId,  String displayName,  String world,  String lineArt,  String regionMask,  int regionCount,  String difficulty,  List<RegionDefinition> regions,  List<HiddenEventDefinition> hiddenEvents,  RewardBundle completionRewards,  List<String> weatherSequence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelDefinition() when $default != null:
return $default(_that.levelId,_that.displayName,_that.world,_that.lineArt,_that.regionMask,_that.regionCount,_that.difficulty,_that.regions,_that.hiddenEvents,_that.completionRewards,_that.weatherSequence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String levelId,  String displayName,  String world,  String lineArt,  String regionMask,  int regionCount,  String difficulty,  List<RegionDefinition> regions,  List<HiddenEventDefinition> hiddenEvents,  RewardBundle completionRewards,  List<String> weatherSequence)  $default,) {final _that = this;
switch (_that) {
case _LevelDefinition():
return $default(_that.levelId,_that.displayName,_that.world,_that.lineArt,_that.regionMask,_that.regionCount,_that.difficulty,_that.regions,_that.hiddenEvents,_that.completionRewards,_that.weatherSequence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String levelId,  String displayName,  String world,  String lineArt,  String regionMask,  int regionCount,  String difficulty,  List<RegionDefinition> regions,  List<HiddenEventDefinition> hiddenEvents,  RewardBundle completionRewards,  List<String> weatherSequence)?  $default,) {final _that = this;
switch (_that) {
case _LevelDefinition() when $default != null:
return $default(_that.levelId,_that.displayName,_that.world,_that.lineArt,_that.regionMask,_that.regionCount,_that.difficulty,_that.regions,_that.hiddenEvents,_that.completionRewards,_that.weatherSequence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LevelDefinition implements LevelDefinition {
  const _LevelDefinition({required this.levelId, required this.displayName, required this.world, required this.lineArt, required this.regionMask, required this.regionCount, required this.difficulty, required final  List<RegionDefinition> regions, required final  List<HiddenEventDefinition> hiddenEvents, required this.completionRewards, final  List<String> weatherSequence = const []}): _regions = regions,_hiddenEvents = hiddenEvents,_weatherSequence = weatherSequence;
  factory _LevelDefinition.fromJson(Map<String, dynamic> json) => _$LevelDefinitionFromJson(json);

@override final  String levelId;
@override final  String displayName;
@override final  String world;
@override final  String lineArt;
@override final  String regionMask;
@override final  int regionCount;
@override final  String difficulty;
 final  List<RegionDefinition> _regions;
@override List<RegionDefinition> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<HiddenEventDefinition> _hiddenEvents;
@override List<HiddenEventDefinition> get hiddenEvents {
  if (_hiddenEvents is EqualUnmodifiableListView) return _hiddenEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hiddenEvents);
}

@override final  RewardBundle completionRewards;
 final  List<String> _weatherSequence;
@override@JsonKey() List<String> get weatherSequence {
  if (_weatherSequence is EqualUnmodifiableListView) return _weatherSequence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherSequence);
}


/// Create a copy of LevelDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelDefinitionCopyWith<_LevelDefinition> get copyWith => __$LevelDefinitionCopyWithImpl<_LevelDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LevelDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelDefinition&&(identical(other.levelId, levelId) || other.levelId == levelId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.world, world) || other.world == world)&&(identical(other.lineArt, lineArt) || other.lineArt == lineArt)&&(identical(other.regionMask, regionMask) || other.regionMask == regionMask)&&(identical(other.regionCount, regionCount) || other.regionCount == regionCount)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._hiddenEvents, _hiddenEvents)&&(identical(other.completionRewards, completionRewards) || other.completionRewards == completionRewards)&&const DeepCollectionEquality().equals(other._weatherSequence, _weatherSequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,levelId,displayName,world,lineArt,regionMask,regionCount,difficulty,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_hiddenEvents),completionRewards,const DeepCollectionEquality().hash(_weatherSequence));

@override
String toString() {
  return 'LevelDefinition(levelId: $levelId, displayName: $displayName, world: $world, lineArt: $lineArt, regionMask: $regionMask, regionCount: $regionCount, difficulty: $difficulty, regions: $regions, hiddenEvents: $hiddenEvents, completionRewards: $completionRewards, weatherSequence: $weatherSequence)';
}


}

/// @nodoc
abstract mixin class _$LevelDefinitionCopyWith<$Res> implements $LevelDefinitionCopyWith<$Res> {
  factory _$LevelDefinitionCopyWith(_LevelDefinition value, $Res Function(_LevelDefinition) _then) = __$LevelDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String levelId, String displayName, String world, String lineArt, String regionMask, int regionCount, String difficulty, List<RegionDefinition> regions, List<HiddenEventDefinition> hiddenEvents, RewardBundle completionRewards, List<String> weatherSequence
});


@override $RewardBundleCopyWith<$Res> get completionRewards;

}
/// @nodoc
class __$LevelDefinitionCopyWithImpl<$Res>
    implements _$LevelDefinitionCopyWith<$Res> {
  __$LevelDefinitionCopyWithImpl(this._self, this._then);

  final _LevelDefinition _self;
  final $Res Function(_LevelDefinition) _then;

/// Create a copy of LevelDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? levelId = null,Object? displayName = null,Object? world = null,Object? lineArt = null,Object? regionMask = null,Object? regionCount = null,Object? difficulty = null,Object? regions = null,Object? hiddenEvents = null,Object? completionRewards = null,Object? weatherSequence = null,}) {
  return _then(_LevelDefinition(
levelId: null == levelId ? _self.levelId : levelId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,world: null == world ? _self.world : world // ignore: cast_nullable_to_non_nullable
as String,lineArt: null == lineArt ? _self.lineArt : lineArt // ignore: cast_nullable_to_non_nullable
as String,regionMask: null == regionMask ? _self.regionMask : regionMask // ignore: cast_nullable_to_non_nullable
as String,regionCount: null == regionCount ? _self.regionCount : regionCount // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<RegionDefinition>,hiddenEvents: null == hiddenEvents ? _self._hiddenEvents : hiddenEvents // ignore: cast_nullable_to_non_nullable
as List<HiddenEventDefinition>,completionRewards: null == completionRewards ? _self.completionRewards : completionRewards // ignore: cast_nullable_to_non_nullable
as RewardBundle,weatherSequence: null == weatherSequence ? _self._weatherSequence : weatherSequence // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of LevelDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardBundleCopyWith<$Res> get completionRewards {
  
  return $RewardBundleCopyWith<$Res>(_self.completionRewards, (value) {
    return _then(_self.copyWith(completionRewards: value));
  });
}
}

// dart format on
