// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_bundle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardBundle {

 int get coins; int get gems; int get xp; int get wood; int get stone; int get crystal; int get food; int get gold;
/// Create a copy of RewardBundle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardBundleCopyWith<RewardBundle> get copyWith => _$RewardBundleCopyWithImpl<RewardBundle>(this as RewardBundle, _$identity);

  /// Serializes this RewardBundle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardBundle&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.gems, gems) || other.gems == gems)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.wood, wood) || other.wood == wood)&&(identical(other.stone, stone) || other.stone == stone)&&(identical(other.crystal, crystal) || other.crystal == crystal)&&(identical(other.food, food) || other.food == food)&&(identical(other.gold, gold) || other.gold == gold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coins,gems,xp,wood,stone,crystal,food,gold);

@override
String toString() {
  return 'RewardBundle(coins: $coins, gems: $gems, xp: $xp, wood: $wood, stone: $stone, crystal: $crystal, food: $food, gold: $gold)';
}


}

/// @nodoc
abstract mixin class $RewardBundleCopyWith<$Res>  {
  factory $RewardBundleCopyWith(RewardBundle value, $Res Function(RewardBundle) _then) = _$RewardBundleCopyWithImpl;
@useResult
$Res call({
 int coins, int gems, int xp, int wood, int stone, int crystal, int food, int gold
});




}
/// @nodoc
class _$RewardBundleCopyWithImpl<$Res>
    implements $RewardBundleCopyWith<$Res> {
  _$RewardBundleCopyWithImpl(this._self, this._then);

  final RewardBundle _self;
  final $Res Function(RewardBundle) _then;

/// Create a copy of RewardBundle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coins = null,Object? gems = null,Object? xp = null,Object? wood = null,Object? stone = null,Object? crystal = null,Object? food = null,Object? gold = null,}) {
  return _then(_self.copyWith(
coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,gems: null == gems ? _self.gems : gems // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,wood: null == wood ? _self.wood : wood // ignore: cast_nullable_to_non_nullable
as int,stone: null == stone ? _self.stone : stone // ignore: cast_nullable_to_non_nullable
as int,crystal: null == crystal ? _self.crystal : crystal // ignore: cast_nullable_to_non_nullable
as int,food: null == food ? _self.food : food // ignore: cast_nullable_to_non_nullable
as int,gold: null == gold ? _self.gold : gold // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardBundle].
extension RewardBundlePatterns on RewardBundle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardBundle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardBundle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardBundle value)  $default,){
final _that = this;
switch (_that) {
case _RewardBundle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardBundle value)?  $default,){
final _that = this;
switch (_that) {
case _RewardBundle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int coins,  int gems,  int xp,  int wood,  int stone,  int crystal,  int food,  int gold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardBundle() when $default != null:
return $default(_that.coins,_that.gems,_that.xp,_that.wood,_that.stone,_that.crystal,_that.food,_that.gold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int coins,  int gems,  int xp,  int wood,  int stone,  int crystal,  int food,  int gold)  $default,) {final _that = this;
switch (_that) {
case _RewardBundle():
return $default(_that.coins,_that.gems,_that.xp,_that.wood,_that.stone,_that.crystal,_that.food,_that.gold);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int coins,  int gems,  int xp,  int wood,  int stone,  int crystal,  int food,  int gold)?  $default,) {final _that = this;
switch (_that) {
case _RewardBundle() when $default != null:
return $default(_that.coins,_that.gems,_that.xp,_that.wood,_that.stone,_that.crystal,_that.food,_that.gold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardBundle implements RewardBundle {
  const _RewardBundle({this.coins = 0, this.gems = 0, this.xp = 0, this.wood = 0, this.stone = 0, this.crystal = 0, this.food = 0, this.gold = 0});
  factory _RewardBundle.fromJson(Map<String, dynamic> json) => _$RewardBundleFromJson(json);

@override@JsonKey() final  int coins;
@override@JsonKey() final  int gems;
@override@JsonKey() final  int xp;
@override@JsonKey() final  int wood;
@override@JsonKey() final  int stone;
@override@JsonKey() final  int crystal;
@override@JsonKey() final  int food;
@override@JsonKey() final  int gold;

/// Create a copy of RewardBundle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardBundleCopyWith<_RewardBundle> get copyWith => __$RewardBundleCopyWithImpl<_RewardBundle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardBundleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardBundle&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.gems, gems) || other.gems == gems)&&(identical(other.xp, xp) || other.xp == xp)&&(identical(other.wood, wood) || other.wood == wood)&&(identical(other.stone, stone) || other.stone == stone)&&(identical(other.crystal, crystal) || other.crystal == crystal)&&(identical(other.food, food) || other.food == food)&&(identical(other.gold, gold) || other.gold == gold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coins,gems,xp,wood,stone,crystal,food,gold);

@override
String toString() {
  return 'RewardBundle(coins: $coins, gems: $gems, xp: $xp, wood: $wood, stone: $stone, crystal: $crystal, food: $food, gold: $gold)';
}


}

/// @nodoc
abstract mixin class _$RewardBundleCopyWith<$Res> implements $RewardBundleCopyWith<$Res> {
  factory _$RewardBundleCopyWith(_RewardBundle value, $Res Function(_RewardBundle) _then) = __$RewardBundleCopyWithImpl;
@override @useResult
$Res call({
 int coins, int gems, int xp, int wood, int stone, int crystal, int food, int gold
});




}
/// @nodoc
class __$RewardBundleCopyWithImpl<$Res>
    implements _$RewardBundleCopyWith<$Res> {
  __$RewardBundleCopyWithImpl(this._self, this._then);

  final _RewardBundle _self;
  final $Res Function(_RewardBundle) _then;

/// Create a copy of RewardBundle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coins = null,Object? gems = null,Object? xp = null,Object? wood = null,Object? stone = null,Object? crystal = null,Object? food = null,Object? gold = null,}) {
  return _then(_RewardBundle(
coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,gems: null == gems ? _self.gems : gems // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,wood: null == wood ? _self.wood : wood // ignore: cast_nullable_to_non_nullable
as int,stone: null == stone ? _self.stone : stone // ignore: cast_nullable_to_non_nullable
as int,crystal: null == crystal ? _self.crystal : crystal // ignore: cast_nullable_to_non_nullable
as int,food: null == food ? _self.food : food // ignore: cast_nullable_to_non_nullable
as int,gold: null == gold ? _self.gold : gold // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
