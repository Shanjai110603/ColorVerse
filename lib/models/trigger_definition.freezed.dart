// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trigger_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
TriggerDefinition _$TriggerDefinitionFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'animation':
          return AnimationTrigger.fromJson(
            json
          );
                case 'sfx':
          return SfxTrigger.fromJson(
            json
          );
                case 'chain':
          return ChainTrigger.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'TriggerDefinition',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$TriggerDefinition {



  /// Serializes this TriggerDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriggerDefinition);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TriggerDefinition()';
}


}

/// @nodoc
class $TriggerDefinitionCopyWith<$Res>  {
$TriggerDefinitionCopyWith(TriggerDefinition _, $Res Function(TriggerDefinition) __);
}


/// Adds pattern-matching-related methods to [TriggerDefinition].
extension TriggerDefinitionPatterns on TriggerDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AnimationTrigger value)?  animation,TResult Function( SfxTrigger value)?  sfx,TResult Function( ChainTrigger value)?  chain,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AnimationTrigger() when animation != null:
return animation(_that);case SfxTrigger() when sfx != null:
return sfx(_that);case ChainTrigger() when chain != null:
return chain(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AnimationTrigger value)  animation,required TResult Function( SfxTrigger value)  sfx,required TResult Function( ChainTrigger value)  chain,}){
final _that = this;
switch (_that) {
case AnimationTrigger():
return animation(_that);case SfxTrigger():
return sfx(_that);case ChainTrigger():
return chain(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AnimationTrigger value)?  animation,TResult? Function( SfxTrigger value)?  sfx,TResult? Function( ChainTrigger value)?  chain,}){
final _that = this;
switch (_that) {
case AnimationTrigger() when animation != null:
return animation(_that);case SfxTrigger() when sfx != null:
return sfx(_that);case ChainTrigger() when chain != null:
return chain(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String asset,  String anchor)?  animation,TResult Function( String asset)?  sfx,TResult Function( int targetRegionId,  int delayMs)?  chain,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AnimationTrigger() when animation != null:
return animation(_that.asset,_that.anchor);case SfxTrigger() when sfx != null:
return sfx(_that.asset);case ChainTrigger() when chain != null:
return chain(_that.targetRegionId,_that.delayMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String asset,  String anchor)  animation,required TResult Function( String asset)  sfx,required TResult Function( int targetRegionId,  int delayMs)  chain,}) {final _that = this;
switch (_that) {
case AnimationTrigger():
return animation(_that.asset,_that.anchor);case SfxTrigger():
return sfx(_that.asset);case ChainTrigger():
return chain(_that.targetRegionId,_that.delayMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String asset,  String anchor)?  animation,TResult? Function( String asset)?  sfx,TResult? Function( int targetRegionId,  int delayMs)?  chain,}) {final _that = this;
switch (_that) {
case AnimationTrigger() when animation != null:
return animation(_that.asset,_that.anchor);case SfxTrigger() when sfx != null:
return sfx(_that.asset);case ChainTrigger() when chain != null:
return chain(_that.targetRegionId,_that.delayMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AnimationTrigger implements TriggerDefinition {
  const AnimationTrigger({required this.asset, required this.anchor, final  String? $type}): $type = $type ?? 'animation';
  factory AnimationTrigger.fromJson(Map<String, dynamic> json) => _$AnimationTriggerFromJson(json);

 final  String asset;
 final  String anchor;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TriggerDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimationTriggerCopyWith<AnimationTrigger> get copyWith => _$AnimationTriggerCopyWithImpl<AnimationTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimationTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimationTrigger&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.anchor, anchor) || other.anchor == anchor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,anchor);

@override
String toString() {
  return 'TriggerDefinition.animation(asset: $asset, anchor: $anchor)';
}


}

/// @nodoc
abstract mixin class $AnimationTriggerCopyWith<$Res> implements $TriggerDefinitionCopyWith<$Res> {
  factory $AnimationTriggerCopyWith(AnimationTrigger value, $Res Function(AnimationTrigger) _then) = _$AnimationTriggerCopyWithImpl;
@useResult
$Res call({
 String asset, String anchor
});




}
/// @nodoc
class _$AnimationTriggerCopyWithImpl<$Res>
    implements $AnimationTriggerCopyWith<$Res> {
  _$AnimationTriggerCopyWithImpl(this._self, this._then);

  final AnimationTrigger _self;
  final $Res Function(AnimationTrigger) _then;

/// Create a copy of TriggerDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? anchor = null,}) {
  return _then(AnimationTrigger(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SfxTrigger implements TriggerDefinition {
  const SfxTrigger({required this.asset, final  String? $type}): $type = $type ?? 'sfx';
  factory SfxTrigger.fromJson(Map<String, dynamic> json) => _$SfxTriggerFromJson(json);

 final  String asset;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TriggerDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SfxTriggerCopyWith<SfxTrigger> get copyWith => _$SfxTriggerCopyWithImpl<SfxTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SfxTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SfxTrigger&&(identical(other.asset, asset) || other.asset == asset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset);

@override
String toString() {
  return 'TriggerDefinition.sfx(asset: $asset)';
}


}

/// @nodoc
abstract mixin class $SfxTriggerCopyWith<$Res> implements $TriggerDefinitionCopyWith<$Res> {
  factory $SfxTriggerCopyWith(SfxTrigger value, $Res Function(SfxTrigger) _then) = _$SfxTriggerCopyWithImpl;
@useResult
$Res call({
 String asset
});




}
/// @nodoc
class _$SfxTriggerCopyWithImpl<$Res>
    implements $SfxTriggerCopyWith<$Res> {
  _$SfxTriggerCopyWithImpl(this._self, this._then);

  final SfxTrigger _self;
  final $Res Function(SfxTrigger) _then;

/// Create a copy of TriggerDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? asset = null,}) {
  return _then(SfxTrigger(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ChainTrigger implements TriggerDefinition {
  const ChainTrigger({required this.targetRegionId, required this.delayMs, final  String? $type}): $type = $type ?? 'chain';
  factory ChainTrigger.fromJson(Map<String, dynamic> json) => _$ChainTriggerFromJson(json);

 final  int targetRegionId;
 final  int delayMs;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TriggerDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChainTriggerCopyWith<ChainTrigger> get copyWith => _$ChainTriggerCopyWithImpl<ChainTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChainTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChainTrigger&&(identical(other.targetRegionId, targetRegionId) || other.targetRegionId == targetRegionId)&&(identical(other.delayMs, delayMs) || other.delayMs == delayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetRegionId,delayMs);

@override
String toString() {
  return 'TriggerDefinition.chain(targetRegionId: $targetRegionId, delayMs: $delayMs)';
}


}

/// @nodoc
abstract mixin class $ChainTriggerCopyWith<$Res> implements $TriggerDefinitionCopyWith<$Res> {
  factory $ChainTriggerCopyWith(ChainTrigger value, $Res Function(ChainTrigger) _then) = _$ChainTriggerCopyWithImpl;
@useResult
$Res call({
 int targetRegionId, int delayMs
});




}
/// @nodoc
class _$ChainTriggerCopyWithImpl<$Res>
    implements $ChainTriggerCopyWith<$Res> {
  _$ChainTriggerCopyWithImpl(this._self, this._then);

  final ChainTrigger _self;
  final $Res Function(ChainTrigger) _then;

/// Create a copy of TriggerDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetRegionId = null,Object? delayMs = null,}) {
  return _then(ChainTrigger(
targetRegionId: null == targetRegionId ? _self.targetRegionId : targetRegionId // ignore: cast_nullable_to_non_nullable
as int,delayMs: null == delayMs ? _self.delayMs : delayMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
