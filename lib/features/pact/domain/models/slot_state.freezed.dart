// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlotState {

 int get totalSlots; int get usedSlots; int get completedPactCount; int? get pactsUntilNextSlot;
/// Create a copy of SlotState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotStateCopyWith<SlotState> get copyWith => _$SlotStateCopyWithImpl<SlotState>(this as SlotState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotState&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&(identical(other.usedSlots, usedSlots) || other.usedSlots == usedSlots)&&(identical(other.completedPactCount, completedPactCount) || other.completedPactCount == completedPactCount)&&(identical(other.pactsUntilNextSlot, pactsUntilNextSlot) || other.pactsUntilNextSlot == pactsUntilNextSlot));
}


@override
int get hashCode => Object.hash(runtimeType,totalSlots,usedSlots,completedPactCount,pactsUntilNextSlot);

@override
String toString() {
  return 'SlotState(totalSlots: $totalSlots, usedSlots: $usedSlots, completedPactCount: $completedPactCount, pactsUntilNextSlot: $pactsUntilNextSlot)';
}


}

/// @nodoc
abstract mixin class $SlotStateCopyWith<$Res>  {
  factory $SlotStateCopyWith(SlotState value, $Res Function(SlotState) _then) = _$SlotStateCopyWithImpl;
@useResult
$Res call({
 int totalSlots, int usedSlots, int completedPactCount, int? pactsUntilNextSlot
});




}
/// @nodoc
class _$SlotStateCopyWithImpl<$Res>
    implements $SlotStateCopyWith<$Res> {
  _$SlotStateCopyWithImpl(this._self, this._then);

  final SlotState _self;
  final $Res Function(SlotState) _then;

/// Create a copy of SlotState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSlots = null,Object? usedSlots = null,Object? completedPactCount = null,Object? pactsUntilNextSlot = freezed,}) {
  return _then(_self.copyWith(
totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,usedSlots: null == usedSlots ? _self.usedSlots : usedSlots // ignore: cast_nullable_to_non_nullable
as int,completedPactCount: null == completedPactCount ? _self.completedPactCount : completedPactCount // ignore: cast_nullable_to_non_nullable
as int,pactsUntilNextSlot: freezed == pactsUntilNextSlot ? _self.pactsUntilNextSlot : pactsUntilNextSlot // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotState].
extension SlotStatePatterns on SlotState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotState value)  $default,){
final _that = this;
switch (_that) {
case _SlotState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotState value)?  $default,){
final _that = this;
switch (_that) {
case _SlotState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSlots,  int usedSlots,  int completedPactCount,  int? pactsUntilNextSlot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotState() when $default != null:
return $default(_that.totalSlots,_that.usedSlots,_that.completedPactCount,_that.pactsUntilNextSlot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSlots,  int usedSlots,  int completedPactCount,  int? pactsUntilNextSlot)  $default,) {final _that = this;
switch (_that) {
case _SlotState():
return $default(_that.totalSlots,_that.usedSlots,_that.completedPactCount,_that.pactsUntilNextSlot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSlots,  int usedSlots,  int completedPactCount,  int? pactsUntilNextSlot)?  $default,) {final _that = this;
switch (_that) {
case _SlotState() when $default != null:
return $default(_that.totalSlots,_that.usedSlots,_that.completedPactCount,_that.pactsUntilNextSlot);case _:
  return null;

}
}

}

/// @nodoc


class _SlotState extends SlotState {
  const _SlotState({required this.totalSlots, required this.usedSlots, required this.completedPactCount, required this.pactsUntilNextSlot}): super._();
  

@override final  int totalSlots;
@override final  int usedSlots;
@override final  int completedPactCount;
@override final  int? pactsUntilNextSlot;

/// Create a copy of SlotState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotStateCopyWith<_SlotState> get copyWith => __$SlotStateCopyWithImpl<_SlotState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotState&&(identical(other.totalSlots, totalSlots) || other.totalSlots == totalSlots)&&(identical(other.usedSlots, usedSlots) || other.usedSlots == usedSlots)&&(identical(other.completedPactCount, completedPactCount) || other.completedPactCount == completedPactCount)&&(identical(other.pactsUntilNextSlot, pactsUntilNextSlot) || other.pactsUntilNextSlot == pactsUntilNextSlot));
}


@override
int get hashCode => Object.hash(runtimeType,totalSlots,usedSlots,completedPactCount,pactsUntilNextSlot);

@override
String toString() {
  return 'SlotState(totalSlots: $totalSlots, usedSlots: $usedSlots, completedPactCount: $completedPactCount, pactsUntilNextSlot: $pactsUntilNextSlot)';
}


}

/// @nodoc
abstract mixin class _$SlotStateCopyWith<$Res> implements $SlotStateCopyWith<$Res> {
  factory _$SlotStateCopyWith(_SlotState value, $Res Function(_SlotState) _then) = __$SlotStateCopyWithImpl;
@override @useResult
$Res call({
 int totalSlots, int usedSlots, int completedPactCount, int? pactsUntilNextSlot
});




}
/// @nodoc
class __$SlotStateCopyWithImpl<$Res>
    implements _$SlotStateCopyWith<$Res> {
  __$SlotStateCopyWithImpl(this._self, this._then);

  final _SlotState _self;
  final $Res Function(_SlotState) _then;

/// Create a copy of SlotState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSlots = null,Object? usedSlots = null,Object? completedPactCount = null,Object? pactsUntilNextSlot = freezed,}) {
  return _then(_SlotState(
totalSlots: null == totalSlots ? _self.totalSlots : totalSlots // ignore: cast_nullable_to_non_nullable
as int,usedSlots: null == usedSlots ? _self.usedSlots : usedSlots // ignore: cast_nullable_to_non_nullable
as int,completedPactCount: null == completedPactCount ? _self.completedPactCount : completedPactCount // ignore: cast_nullable_to_non_nullable
as int,pactsUntilNextSlot: freezed == pactsUntilNextSlot ? _self.pactsUntilNextSlot : pactsUntilNextSlot // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
