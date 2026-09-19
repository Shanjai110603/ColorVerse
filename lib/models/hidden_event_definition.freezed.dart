// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hidden_event_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HiddenEventDefinition {

 String get id; EventCondition get condition; EventReveal get reveal;
/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HiddenEventDefinitionCopyWith<HiddenEventDefinition> get copyWith => _$HiddenEventDefinitionCopyWithImpl<HiddenEventDefinition>(this as HiddenEventDefinition, _$identity);

  /// Serializes this HiddenEventDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HiddenEventDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.reveal, reveal) || other.reveal == reveal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,condition,reveal);

@override
String toString() {
  return 'HiddenEventDefinition(id: $id, condition: $condition, reveal: $reveal)';
}


}

/// @nodoc
abstract mixin class $HiddenEventDefinitionCopyWith<$Res>  {
  factory $HiddenEventDefinitionCopyWith(HiddenEventDefinition value, $Res Function(HiddenEventDefinition) _then) = _$HiddenEventDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, EventCondition condition, EventReveal reveal
});


$EventConditionCopyWith<$Res> get condition;$EventRevealCopyWith<$Res> get reveal;

}
/// @nodoc
class _$HiddenEventDefinitionCopyWithImpl<$Res>
    implements $HiddenEventDefinitionCopyWith<$Res> {
  _$HiddenEventDefinitionCopyWithImpl(this._self, this._then);

  final HiddenEventDefinition _self;
  final $Res Function(HiddenEventDefinition) _then;

/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? condition = null,Object? reveal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as EventCondition,reveal: null == reveal ? _self.reveal : reveal // ignore: cast_nullable_to_non_nullable
as EventReveal,
  ));
}
/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventConditionCopyWith<$Res> get condition {
  
  return $EventConditionCopyWith<$Res>(_self.condition, (value) {
    return _then(_self.copyWith(condition: value));
  });
}/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventRevealCopyWith<$Res> get reveal {
  
  return $EventRevealCopyWith<$Res>(_self.reveal, (value) {
    return _then(_self.copyWith(reveal: value));
  });
}
}


/// Adds pattern-matching-related methods to [HiddenEventDefinition].
extension HiddenEventDefinitionPatterns on HiddenEventDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HiddenEventDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HiddenEventDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HiddenEventDefinition value)  $default,){
final _that = this;
switch (_that) {
case _HiddenEventDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HiddenEventDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _HiddenEventDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EventCondition condition,  EventReveal reveal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HiddenEventDefinition() when $default != null:
return $default(_that.id,_that.condition,_that.reveal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EventCondition condition,  EventReveal reveal)  $default,) {final _that = this;
switch (_that) {
case _HiddenEventDefinition():
return $default(_that.id,_that.condition,_that.reveal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EventCondition condition,  EventReveal reveal)?  $default,) {final _that = this;
switch (_that) {
case _HiddenEventDefinition() when $default != null:
return $default(_that.id,_that.condition,_that.reveal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HiddenEventDefinition implements HiddenEventDefinition {
  const _HiddenEventDefinition({required this.id, required this.condition, required this.reveal});
  factory _HiddenEventDefinition.fromJson(Map<String, dynamic> json) => _$HiddenEventDefinitionFromJson(json);

@override final  String id;
@override final  EventCondition condition;
@override final  EventReveal reveal;

/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HiddenEventDefinitionCopyWith<_HiddenEventDefinition> get copyWith => __$HiddenEventDefinitionCopyWithImpl<_HiddenEventDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HiddenEventDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HiddenEventDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.reveal, reveal) || other.reveal == reveal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,condition,reveal);

@override
String toString() {
  return 'HiddenEventDefinition(id: $id, condition: $condition, reveal: $reveal)';
}


}

/// @nodoc
abstract mixin class _$HiddenEventDefinitionCopyWith<$Res> implements $HiddenEventDefinitionCopyWith<$Res> {
  factory _$HiddenEventDefinitionCopyWith(_HiddenEventDefinition value, $Res Function(_HiddenEventDefinition) _then) = __$HiddenEventDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, EventCondition condition, EventReveal reveal
});


@override $EventConditionCopyWith<$Res> get condition;@override $EventRevealCopyWith<$Res> get reveal;

}
/// @nodoc
class __$HiddenEventDefinitionCopyWithImpl<$Res>
    implements _$HiddenEventDefinitionCopyWith<$Res> {
  __$HiddenEventDefinitionCopyWithImpl(this._self, this._then);

  final _HiddenEventDefinition _self;
  final $Res Function(_HiddenEventDefinition) _then;

/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? condition = null,Object? reveal = null,}) {
  return _then(_HiddenEventDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as EventCondition,reveal: null == reveal ? _self.reveal : reveal // ignore: cast_nullable_to_non_nullable
as EventReveal,
  ));
}

/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventConditionCopyWith<$Res> get condition {
  
  return $EventConditionCopyWith<$Res>(_self.condition, (value) {
    return _then(_self.copyWith(condition: value));
  });
}/// Create a copy of HiddenEventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventRevealCopyWith<$Res> get reveal {
  
  return $EventRevealCopyWith<$Res>(_self.reveal, (value) {
    return _then(_self.copyWith(reveal: value));
  });
}
}

EventCondition _$EventConditionFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'allRegionsFilled':
          return AllRegionsFilledCondition.fromJson(
            json
          );
                case 'anyRegionFilled':
          return AnyRegionFilledCondition.fromJson(
            json
          );
                case 'regionFilledWithinTime':
          return RegionFilledWithinTimeCondition.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'EventCondition',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$EventCondition {

 List<int> get regionIds;
/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventConditionCopyWith<EventCondition> get copyWith => _$EventConditionCopyWithImpl<EventCondition>(this as EventCondition, _$identity);

  /// Serializes this EventCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventCondition&&const DeepCollectionEquality().equals(other.regionIds, regionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(regionIds));

@override
String toString() {
  return 'EventCondition(regionIds: $regionIds)';
}


}

/// @nodoc
abstract mixin class $EventConditionCopyWith<$Res>  {
  factory $EventConditionCopyWith(EventCondition value, $Res Function(EventCondition) _then) = _$EventConditionCopyWithImpl;
@useResult
$Res call({
 List<int> regionIds
});




}
/// @nodoc
class _$EventConditionCopyWithImpl<$Res>
    implements $EventConditionCopyWith<$Res> {
  _$EventConditionCopyWithImpl(this._self, this._then);

  final EventCondition _self;
  final $Res Function(EventCondition) _then;

/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionIds = null,}) {
  return _then(_self.copyWith(
regionIds: null == regionIds ? _self.regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventCondition].
extension EventConditionPatterns on EventCondition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AllRegionsFilledCondition value)?  allRegionsFilled,TResult Function( AnyRegionFilledCondition value)?  anyRegionFilled,TResult Function( RegionFilledWithinTimeCondition value)?  regionFilledWithinTime,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AllRegionsFilledCondition() when allRegionsFilled != null:
return allRegionsFilled(_that);case AnyRegionFilledCondition() when anyRegionFilled != null:
return anyRegionFilled(_that);case RegionFilledWithinTimeCondition() when regionFilledWithinTime != null:
return regionFilledWithinTime(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AllRegionsFilledCondition value)  allRegionsFilled,required TResult Function( AnyRegionFilledCondition value)  anyRegionFilled,required TResult Function( RegionFilledWithinTimeCondition value)  regionFilledWithinTime,}){
final _that = this;
switch (_that) {
case AllRegionsFilledCondition():
return allRegionsFilled(_that);case AnyRegionFilledCondition():
return anyRegionFilled(_that);case RegionFilledWithinTimeCondition():
return regionFilledWithinTime(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AllRegionsFilledCondition value)?  allRegionsFilled,TResult? Function( AnyRegionFilledCondition value)?  anyRegionFilled,TResult? Function( RegionFilledWithinTimeCondition value)?  regionFilledWithinTime,}){
final _that = this;
switch (_that) {
case AllRegionsFilledCondition() when allRegionsFilled != null:
return allRegionsFilled(_that);case AnyRegionFilledCondition() when anyRegionFilled != null:
return anyRegionFilled(_that);case RegionFilledWithinTimeCondition() when regionFilledWithinTime != null:
return regionFilledWithinTime(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<int> regionIds)?  allRegionsFilled,TResult Function( List<int> regionIds)?  anyRegionFilled,TResult Function( List<int> regionIds,  int timeLimitMs)?  regionFilledWithinTime,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AllRegionsFilledCondition() when allRegionsFilled != null:
return allRegionsFilled(_that.regionIds);case AnyRegionFilledCondition() when anyRegionFilled != null:
return anyRegionFilled(_that.regionIds);case RegionFilledWithinTimeCondition() when regionFilledWithinTime != null:
return regionFilledWithinTime(_that.regionIds,_that.timeLimitMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<int> regionIds)  allRegionsFilled,required TResult Function( List<int> regionIds)  anyRegionFilled,required TResult Function( List<int> regionIds,  int timeLimitMs)  regionFilledWithinTime,}) {final _that = this;
switch (_that) {
case AllRegionsFilledCondition():
return allRegionsFilled(_that.regionIds);case AnyRegionFilledCondition():
return anyRegionFilled(_that.regionIds);case RegionFilledWithinTimeCondition():
return regionFilledWithinTime(_that.regionIds,_that.timeLimitMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<int> regionIds)?  allRegionsFilled,TResult? Function( List<int> regionIds)?  anyRegionFilled,TResult? Function( List<int> regionIds,  int timeLimitMs)?  regionFilledWithinTime,}) {final _that = this;
switch (_that) {
case AllRegionsFilledCondition() when allRegionsFilled != null:
return allRegionsFilled(_that.regionIds);case AnyRegionFilledCondition() when anyRegionFilled != null:
return anyRegionFilled(_that.regionIds);case RegionFilledWithinTimeCondition() when regionFilledWithinTime != null:
return regionFilledWithinTime(_that.regionIds,_that.timeLimitMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AllRegionsFilledCondition implements EventCondition {
  const AllRegionsFilledCondition({required final  List<int> regionIds, final  String? $type}): _regionIds = regionIds,$type = $type ?? 'allRegionsFilled';
  factory AllRegionsFilledCondition.fromJson(Map<String, dynamic> json) => _$AllRegionsFilledConditionFromJson(json);

 final  List<int> _regionIds;
@override List<int> get regionIds {
  if (_regionIds is EqualUnmodifiableListView) return _regionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regionIds);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllRegionsFilledConditionCopyWith<AllRegionsFilledCondition> get copyWith => _$AllRegionsFilledConditionCopyWithImpl<AllRegionsFilledCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllRegionsFilledConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRegionsFilledCondition&&const DeepCollectionEquality().equals(other._regionIds, _regionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regionIds));

@override
String toString() {
  return 'EventCondition.allRegionsFilled(regionIds: $regionIds)';
}


}

/// @nodoc
abstract mixin class $AllRegionsFilledConditionCopyWith<$Res> implements $EventConditionCopyWith<$Res> {
  factory $AllRegionsFilledConditionCopyWith(AllRegionsFilledCondition value, $Res Function(AllRegionsFilledCondition) _then) = _$AllRegionsFilledConditionCopyWithImpl;
@override @useResult
$Res call({
 List<int> regionIds
});




}
/// @nodoc
class _$AllRegionsFilledConditionCopyWithImpl<$Res>
    implements $AllRegionsFilledConditionCopyWith<$Res> {
  _$AllRegionsFilledConditionCopyWithImpl(this._self, this._then);

  final AllRegionsFilledCondition _self;
  final $Res Function(AllRegionsFilledCondition) _then;

/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionIds = null,}) {
  return _then(AllRegionsFilledCondition(
regionIds: null == regionIds ? _self._regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnyRegionFilledCondition implements EventCondition {
  const AnyRegionFilledCondition({required final  List<int> regionIds, final  String? $type}): _regionIds = regionIds,$type = $type ?? 'anyRegionFilled';
  factory AnyRegionFilledCondition.fromJson(Map<String, dynamic> json) => _$AnyRegionFilledConditionFromJson(json);

 final  List<int> _regionIds;
@override List<int> get regionIds {
  if (_regionIds is EqualUnmodifiableListView) return _regionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regionIds);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnyRegionFilledConditionCopyWith<AnyRegionFilledCondition> get copyWith => _$AnyRegionFilledConditionCopyWithImpl<AnyRegionFilledCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnyRegionFilledConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnyRegionFilledCondition&&const DeepCollectionEquality().equals(other._regionIds, _regionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regionIds));

@override
String toString() {
  return 'EventCondition.anyRegionFilled(regionIds: $regionIds)';
}


}

/// @nodoc
abstract mixin class $AnyRegionFilledConditionCopyWith<$Res> implements $EventConditionCopyWith<$Res> {
  factory $AnyRegionFilledConditionCopyWith(AnyRegionFilledCondition value, $Res Function(AnyRegionFilledCondition) _then) = _$AnyRegionFilledConditionCopyWithImpl;
@override @useResult
$Res call({
 List<int> regionIds
});




}
/// @nodoc
class _$AnyRegionFilledConditionCopyWithImpl<$Res>
    implements $AnyRegionFilledConditionCopyWith<$Res> {
  _$AnyRegionFilledConditionCopyWithImpl(this._self, this._then);

  final AnyRegionFilledCondition _self;
  final $Res Function(AnyRegionFilledCondition) _then;

/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionIds = null,}) {
  return _then(AnyRegionFilledCondition(
regionIds: null == regionIds ? _self._regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RegionFilledWithinTimeCondition implements EventCondition {
  const RegionFilledWithinTimeCondition({required final  List<int> regionIds, required this.timeLimitMs, final  String? $type}): _regionIds = regionIds,$type = $type ?? 'regionFilledWithinTime';
  factory RegionFilledWithinTimeCondition.fromJson(Map<String, dynamic> json) => _$RegionFilledWithinTimeConditionFromJson(json);

 final  List<int> _regionIds;
@override List<int> get regionIds {
  if (_regionIds is EqualUnmodifiableListView) return _regionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regionIds);
}

 final  int timeLimitMs;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionFilledWithinTimeConditionCopyWith<RegionFilledWithinTimeCondition> get copyWith => _$RegionFilledWithinTimeConditionCopyWithImpl<RegionFilledWithinTimeCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionFilledWithinTimeConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionFilledWithinTimeCondition&&const DeepCollectionEquality().equals(other._regionIds, _regionIds)&&(identical(other.timeLimitMs, timeLimitMs) || other.timeLimitMs == timeLimitMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regionIds),timeLimitMs);

@override
String toString() {
  return 'EventCondition.regionFilledWithinTime(regionIds: $regionIds, timeLimitMs: $timeLimitMs)';
}


}

/// @nodoc
abstract mixin class $RegionFilledWithinTimeConditionCopyWith<$Res> implements $EventConditionCopyWith<$Res> {
  factory $RegionFilledWithinTimeConditionCopyWith(RegionFilledWithinTimeCondition value, $Res Function(RegionFilledWithinTimeCondition) _then) = _$RegionFilledWithinTimeConditionCopyWithImpl;
@override @useResult
$Res call({
 List<int> regionIds, int timeLimitMs
});




}
/// @nodoc
class _$RegionFilledWithinTimeConditionCopyWithImpl<$Res>
    implements $RegionFilledWithinTimeConditionCopyWith<$Res> {
  _$RegionFilledWithinTimeConditionCopyWithImpl(this._self, this._then);

  final RegionFilledWithinTimeCondition _self;
  final $Res Function(RegionFilledWithinTimeCondition) _then;

/// Create a copy of EventCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionIds = null,Object? timeLimitMs = null,}) {
  return _then(RegionFilledWithinTimeCondition(
regionIds: null == regionIds ? _self._regionIds : regionIds // ignore: cast_nullable_to_non_nullable
as List<int>,timeLimitMs: null == timeLimitMs ? _self.timeLimitMs : timeLimitMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

EventReveal _$EventRevealFromJson(
  Map<String, dynamic> json
) {
    return SpriteReveal.fromJson(
      json
    );
}

/// @nodoc
mixin _$EventReveal {

 String get asset; List<double> get position;
/// Create a copy of EventReveal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRevealCopyWith<EventReveal> get copyWith => _$EventRevealCopyWithImpl<EventReveal>(this as EventReveal, _$identity);

  /// Serializes this EventReveal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventReveal&&(identical(other.asset, asset) || other.asset == asset)&&const DeepCollectionEquality().equals(other.position, position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,const DeepCollectionEquality().hash(position));

@override
String toString() {
  return 'EventReveal(asset: $asset, position: $position)';
}


}

/// @nodoc
abstract mixin class $EventRevealCopyWith<$Res>  {
  factory $EventRevealCopyWith(EventReveal value, $Res Function(EventReveal) _then) = _$EventRevealCopyWithImpl;
@useResult
$Res call({
 String asset, List<double> position
});




}
/// @nodoc
class _$EventRevealCopyWithImpl<$Res>
    implements $EventRevealCopyWith<$Res> {
  _$EventRevealCopyWithImpl(this._self, this._then);

  final EventReveal _self;
  final $Res Function(EventReveal) _then;

/// Create a copy of EventReveal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? position = null,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventReveal].
extension EventRevealPatterns on EventReveal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SpriteReveal value)?  spriteReveal,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SpriteReveal() when spriteReveal != null:
return spriteReveal(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SpriteReveal value)  spriteReveal,}){
final _that = this;
switch (_that) {
case SpriteReveal():
return spriteReveal(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SpriteReveal value)?  spriteReveal,}){
final _that = this;
switch (_that) {
case SpriteReveal() when spriteReveal != null:
return spriteReveal(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String asset,  List<double> position)?  spriteReveal,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SpriteReveal() when spriteReveal != null:
return spriteReveal(_that.asset,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String asset,  List<double> position)  spriteReveal,}) {final _that = this;
switch (_that) {
case SpriteReveal():
return spriteReveal(_that.asset,_that.position);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String asset,  List<double> position)?  spriteReveal,}) {final _that = this;
switch (_that) {
case SpriteReveal() when spriteReveal != null:
return spriteReveal(_that.asset,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SpriteReveal implements EventReveal {
  const SpriteReveal({required this.asset, required final  List<double> position}): _position = position;
  factory SpriteReveal.fromJson(Map<String, dynamic> json) => _$SpriteRevealFromJson(json);

@override final  String asset;
 final  List<double> _position;
@override List<double> get position {
  if (_position is EqualUnmodifiableListView) return _position;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_position);
}


/// Create a copy of EventReveal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpriteRevealCopyWith<SpriteReveal> get copyWith => _$SpriteRevealCopyWithImpl<SpriteReveal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpriteRevealToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpriteReveal&&(identical(other.asset, asset) || other.asset == asset)&&const DeepCollectionEquality().equals(other._position, _position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,const DeepCollectionEquality().hash(_position));

@override
String toString() {
  return 'EventReveal.spriteReveal(asset: $asset, position: $position)';
}


}

/// @nodoc
abstract mixin class $SpriteRevealCopyWith<$Res> implements $EventRevealCopyWith<$Res> {
  factory $SpriteRevealCopyWith(SpriteReveal value, $Res Function(SpriteReveal) _then) = _$SpriteRevealCopyWithImpl;
@override @useResult
$Res call({
 String asset, List<double> position
});




}
/// @nodoc
class _$SpriteRevealCopyWithImpl<$Res>
    implements $SpriteRevealCopyWith<$Res> {
  _$SpriteRevealCopyWithImpl(this._self, this._then);

  final SpriteReveal _self;
  final $Res Function(SpriteReveal) _then;

/// Create a copy of EventReveal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? position = null,}) {
  return _then(SpriteReveal(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self._position : position // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
