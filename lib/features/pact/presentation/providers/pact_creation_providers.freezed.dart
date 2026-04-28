// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pact_creation_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PactFormState {

 String get hypothesis; String get action; int get durationDays; PactCadence get cadence; int? get dayOfWeek;// 1 = Mon … 7 = Sun; null means start today (daily)
 String get ifCondition; String get thenAction; CuriosityTemperature? get temperature; bool get showErrors;
/// Create a copy of PactFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PactFormStateCopyWith<PactFormState> get copyWith => _$PactFormStateCopyWithImpl<PactFormState>(this as PactFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PactFormState&&(identical(other.hypothesis, hypothesis) || other.hypothesis == hypothesis)&&(identical(other.action, action) || other.action == action)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.ifCondition, ifCondition) || other.ifCondition == ifCondition)&&(identical(other.thenAction, thenAction) || other.thenAction == thenAction)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors));
}


@override
int get hashCode => Object.hash(runtimeType,hypothesis,action,durationDays,cadence,dayOfWeek,ifCondition,thenAction,temperature,showErrors);

@override
String toString() {
  return 'PactFormState(hypothesis: $hypothesis, action: $action, durationDays: $durationDays, cadence: $cadence, dayOfWeek: $dayOfWeek, ifCondition: $ifCondition, thenAction: $thenAction, temperature: $temperature, showErrors: $showErrors)';
}


}

/// @nodoc
abstract mixin class $PactFormStateCopyWith<$Res>  {
  factory $PactFormStateCopyWith(PactFormState value, $Res Function(PactFormState) _then) = _$PactFormStateCopyWithImpl;
@useResult
$Res call({
 String hypothesis, String action, int durationDays, PactCadence cadence, int? dayOfWeek, String ifCondition, String thenAction, CuriosityTemperature? temperature, bool showErrors
});




}
/// @nodoc
class _$PactFormStateCopyWithImpl<$Res>
    implements $PactFormStateCopyWith<$Res> {
  _$PactFormStateCopyWithImpl(this._self, this._then);

  final PactFormState _self;
  final $Res Function(PactFormState) _then;

/// Create a copy of PactFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hypothesis = null,Object? action = null,Object? durationDays = null,Object? cadence = null,Object? dayOfWeek = freezed,Object? ifCondition = null,Object? thenAction = null,Object? temperature = freezed,Object? showErrors = null,}) {
  return _then(_self.copyWith(
hypothesis: null == hypothesis ? _self.hypothesis : hypothesis // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as PactCadence,dayOfWeek: freezed == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int?,ifCondition: null == ifCondition ? _self.ifCondition : ifCondition // ignore: cast_nullable_to_non_nullable
as String,thenAction: null == thenAction ? _self.thenAction : thenAction // ignore: cast_nullable_to_non_nullable
as String,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as CuriosityTemperature?,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PactFormState].
extension PactFormStatePatterns on PactFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PactFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PactFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PactFormState value)  $default,){
final _that = this;
switch (_that) {
case _PactFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PactFormState value)?  $default,){
final _that = this;
switch (_that) {
case _PactFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String hypothesis,  String action,  int durationDays,  PactCadence cadence,  int? dayOfWeek,  String ifCondition,  String thenAction,  CuriosityTemperature? temperature,  bool showErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PactFormState() when $default != null:
return $default(_that.hypothesis,_that.action,_that.durationDays,_that.cadence,_that.dayOfWeek,_that.ifCondition,_that.thenAction,_that.temperature,_that.showErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String hypothesis,  String action,  int durationDays,  PactCadence cadence,  int? dayOfWeek,  String ifCondition,  String thenAction,  CuriosityTemperature? temperature,  bool showErrors)  $default,) {final _that = this;
switch (_that) {
case _PactFormState():
return $default(_that.hypothesis,_that.action,_that.durationDays,_that.cadence,_that.dayOfWeek,_that.ifCondition,_that.thenAction,_that.temperature,_that.showErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String hypothesis,  String action,  int durationDays,  PactCadence cadence,  int? dayOfWeek,  String ifCondition,  String thenAction,  CuriosityTemperature? temperature,  bool showErrors)?  $default,) {final _that = this;
switch (_that) {
case _PactFormState() when $default != null:
return $default(_that.hypothesis,_that.action,_that.durationDays,_that.cadence,_that.dayOfWeek,_that.ifCondition,_that.thenAction,_that.temperature,_that.showErrors);case _:
  return null;

}
}

}

/// @nodoc


class _PactFormState extends PactFormState {
  const _PactFormState({this.hypothesis = '', this.action = '', this.durationDays = 30, this.cadence = PactCadence.daily, this.dayOfWeek, this.ifCondition = '', this.thenAction = '', this.temperature, this.showErrors = false}): super._();
  

@override@JsonKey() final  String hypothesis;
@override@JsonKey() final  String action;
@override@JsonKey() final  int durationDays;
@override@JsonKey() final  PactCadence cadence;
@override final  int? dayOfWeek;
// 1 = Mon … 7 = Sun; null means start today (daily)
@override@JsonKey() final  String ifCondition;
@override@JsonKey() final  String thenAction;
@override final  CuriosityTemperature? temperature;
@override@JsonKey() final  bool showErrors;

/// Create a copy of PactFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PactFormStateCopyWith<_PactFormState> get copyWith => __$PactFormStateCopyWithImpl<_PactFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PactFormState&&(identical(other.hypothesis, hypothesis) || other.hypothesis == hypothesis)&&(identical(other.action, action) || other.action == action)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.ifCondition, ifCondition) || other.ifCondition == ifCondition)&&(identical(other.thenAction, thenAction) || other.thenAction == thenAction)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors));
}


@override
int get hashCode => Object.hash(runtimeType,hypothesis,action,durationDays,cadence,dayOfWeek,ifCondition,thenAction,temperature,showErrors);

@override
String toString() {
  return 'PactFormState(hypothesis: $hypothesis, action: $action, durationDays: $durationDays, cadence: $cadence, dayOfWeek: $dayOfWeek, ifCondition: $ifCondition, thenAction: $thenAction, temperature: $temperature, showErrors: $showErrors)';
}


}

/// @nodoc
abstract mixin class _$PactFormStateCopyWith<$Res> implements $PactFormStateCopyWith<$Res> {
  factory _$PactFormStateCopyWith(_PactFormState value, $Res Function(_PactFormState) _then) = __$PactFormStateCopyWithImpl;
@override @useResult
$Res call({
 String hypothesis, String action, int durationDays, PactCadence cadence, int? dayOfWeek, String ifCondition, String thenAction, CuriosityTemperature? temperature, bool showErrors
});




}
/// @nodoc
class __$PactFormStateCopyWithImpl<$Res>
    implements _$PactFormStateCopyWith<$Res> {
  __$PactFormStateCopyWithImpl(this._self, this._then);

  final _PactFormState _self;
  final $Res Function(_PactFormState) _then;

/// Create a copy of PactFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hypothesis = null,Object? action = null,Object? durationDays = null,Object? cadence = null,Object? dayOfWeek = freezed,Object? ifCondition = null,Object? thenAction = null,Object? temperature = freezed,Object? showErrors = null,}) {
  return _then(_PactFormState(
hypothesis: null == hypothesis ? _self.hypothesis : hypothesis // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as PactCadence,dayOfWeek: freezed == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int?,ifCondition: null == ifCondition ? _self.ifCondition : ifCondition // ignore: cast_nullable_to_non_nullable
as String,thenAction: null == thenAction ? _self.thenAction : thenAction // ignore: cast_nullable_to_non_nullable
as String,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as CuriosityTemperature?,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
