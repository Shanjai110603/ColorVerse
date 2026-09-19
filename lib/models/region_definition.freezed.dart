// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionDefinition {

 int get id; String get targetColor; int get paletteSlot; List<TriggerDefinition> get onFillTriggers;
/// Create a copy of RegionDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionDefinitionCopyWith<RegionDefinition> get copyWith => _$RegionDefinitionCopyWithImpl<RegionDefinition>(this as RegionDefinition, _$identity);

  /// Serializes this RegionDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.targetColor, targetColor) || other.targetColor == targetColor)&&(identical(other.paletteSlot, paletteSlot) || other.paletteSlot == paletteSlot)&&const DeepCollectionEquality().equals(other.onFillTriggers, onFillTriggers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,targetColor,paletteSlot,const DeepCollectionEquality().hash(onFillTriggers));

@override
String toString() {
  return 'RegionDefinition(id: $id, targetColor: $targetColor, paletteSlot: $paletteSlot, onFillTriggers: $onFillTriggers)';
}


}

/// @nodoc
abstract mixin class $RegionDefinitionCopyWith<$Res>  {
  factory $RegionDefinitionCopyWith(RegionDefinition value, $Res Function(RegionDefinition) _then) = _$RegionDefinitionCopyWithImpl;
@useResult
$Res call({
 int id, String targetColor, int paletteSlot, List<TriggerDefinition> onFillTriggers
});




}
/// @nodoc
class _$RegionDefinitionCopyWithImpl<$Res>
    implements $RegionDefinitionCopyWith<$Res> {
  _$RegionDefinitionCopyWithImpl(this._self, this._then);

  final RegionDefinition _self;
  final $Res Function(RegionDefinition) _then;

/// Create a copy of RegionDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? targetColor = null,Object? paletteSlot = null,Object? onFillTriggers = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,targetColor: null == targetColor ? _self.targetColor : targetColor // ignore: cast_nullable_to_non_nullable
as String,paletteSlot: null == paletteSlot ? _self.paletteSlot : paletteSlot // ignore: cast_nullable_to_non_nullable
as int,onFillTriggers: null == onFillTriggers ? _self.onFillTriggers : onFillTriggers // ignore: cast_nullable_to_non_nullable
as List<TriggerDefinition>,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionDefinition].
extension RegionDefinitionPatterns on RegionDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionDefinition value)  $default,){
final _that = this;
switch (_that) {
case _RegionDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _RegionDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String targetColor,  int paletteSlot,  List<TriggerDefinition> onFillTriggers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionDefinition() when $default != null:
return $default(_that.id,_that.targetColor,_that.paletteSlot,_that.onFillTriggers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String targetColor,  int paletteSlot,  List<TriggerDefinition> onFillTriggers)  $default,) {final _that = this;
switch (_that) {
case _RegionDefinition():
return $default(_that.id,_that.targetColor,_that.paletteSlot,_that.onFillTriggers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String targetColor,  int paletteSlot,  List<TriggerDefinition> onFillTriggers)?  $default,) {final _that = this;
switch (_that) {
case _RegionDefinition() when $default != null:
return $default(_that.id,_that.targetColor,_that.paletteSlot,_that.onFillTriggers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionDefinition implements RegionDefinition {
  const _RegionDefinition({required this.id, required this.targetColor, required this.paletteSlot, final  List<TriggerDefinition> onFillTriggers = const []}): _onFillTriggers = onFillTriggers;
  factory _RegionDefinition.fromJson(Map<String, dynamic> json) => _$RegionDefinitionFromJson(json);

@override final  int id;
@override final  String targetColor;
@override final  int paletteSlot;
 final  List<TriggerDefinition> _onFillTriggers;
@override@JsonKey() List<TriggerDefinition> get onFillTriggers {
  if (_onFillTriggers is EqualUnmodifiableListView) return _onFillTriggers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_onFillTriggers);
}


/// Create a copy of RegionDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionDefinitionCopyWith<_RegionDefinition> get copyWith => __$RegionDefinitionCopyWithImpl<_RegionDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.targetColor, targetColor) || other.targetColor == targetColor)&&(identical(other.paletteSlot, paletteSlot) || other.paletteSlot == paletteSlot)&&const DeepCollectionEquality().equals(other._onFillTriggers, _onFillTriggers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,targetColor,paletteSlot,const DeepCollectionEquality().hash(_onFillTriggers));

@override
String toString() {
  return 'RegionDefinition(id: $id, targetColor: $targetColor, paletteSlot: $paletteSlot, onFillTriggers: $onFillTriggers)';
}


}

/// @nodoc
abstract mixin class _$RegionDefinitionCopyWith<$Res> implements $RegionDefinitionCopyWith<$Res> {
  factory _$RegionDefinitionCopyWith(_RegionDefinition value, $Res Function(_RegionDefinition) _then) = __$RegionDefinitionCopyWithImpl;
@override @useResult
$Res call({
 int id, String targetColor, int paletteSlot, List<TriggerDefinition> onFillTriggers
});




}
/// @nodoc
class __$RegionDefinitionCopyWithImpl<$Res>
    implements _$RegionDefinitionCopyWith<$Res> {
  __$RegionDefinitionCopyWithImpl(this._self, this._then);

  final _RegionDefinition _self;
  final $Res Function(_RegionDefinition) _then;

/// Create a copy of RegionDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? targetColor = null,Object? paletteSlot = null,Object? onFillTriggers = null,}) {
  return _then(_RegionDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,targetColor: null == targetColor ? _self.targetColor : targetColor // ignore: cast_nullable_to_non_nullable
as String,paletteSlot: null == paletteSlot ? _self.paletteSlot : paletteSlot // ignore: cast_nullable_to_non_nullable
as int,onFillTriggers: null == onFillTriggers ? _self._onFillTriggers : onFillTriggers // ignore: cast_nullable_to_non_nullable
as List<TriggerDefinition>,
  ));
}


}

// dart format on
