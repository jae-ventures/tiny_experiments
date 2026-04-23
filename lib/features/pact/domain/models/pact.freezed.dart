// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Pact {

 String get id;// UUID
 String get action;// "I will <action>"
 PactCadence get cadence;// daily | weekly | biweekly
 int get durationTrials;// total number of trials committed to
 DateTime get startDate; DateTime get endDate;// derived: startDate + trials × cadence
 PactStatus get status;// active | paused | completed | abandoned
 DateTime get createdAt; String? get ifCondition;// "If <trigger>..."
 String? get thenAction;// "...then <action>"
 String? get hypothesis;// the user's stated curiosity or hypothesis
 CuriosityTemperature? get temperature;// cold | warm | fiery
 int? get reflectionIntervalTrials;
/// Create a copy of Pact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PactCopyWith<Pact> get copyWith => _$PactCopyWithImpl<Pact>(this as Pact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pact&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.durationTrials, durationTrials) || other.durationTrials == durationTrials)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ifCondition, ifCondition) || other.ifCondition == ifCondition)&&(identical(other.thenAction, thenAction) || other.thenAction == thenAction)&&(identical(other.hypothesis, hypothesis) || other.hypothesis == hypothesis)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.reflectionIntervalTrials, reflectionIntervalTrials) || other.reflectionIntervalTrials == reflectionIntervalTrials));
}


@override
int get hashCode => Object.hash(runtimeType,id,action,cadence,durationTrials,startDate,endDate,status,createdAt,ifCondition,thenAction,hypothesis,temperature,reflectionIntervalTrials);

@override
String toString() {
  return 'Pact(id: $id, action: $action, cadence: $cadence, durationTrials: $durationTrials, startDate: $startDate, endDate: $endDate, status: $status, createdAt: $createdAt, ifCondition: $ifCondition, thenAction: $thenAction, hypothesis: $hypothesis, temperature: $temperature, reflectionIntervalTrials: $reflectionIntervalTrials)';
}


}

/// @nodoc
abstract mixin class $PactCopyWith<$Res>  {
  factory $PactCopyWith(Pact value, $Res Function(Pact) _then) = _$PactCopyWithImpl;
@useResult
$Res call({
 String id, String action, PactCadence cadence, int durationTrials, DateTime startDate, DateTime endDate, PactStatus status, DateTime createdAt, String? ifCondition, String? thenAction, String? hypothesis, CuriosityTemperature? temperature, int? reflectionIntervalTrials
});




}
/// @nodoc
class _$PactCopyWithImpl<$Res>
    implements $PactCopyWith<$Res> {
  _$PactCopyWithImpl(this._self, this._then);

  final Pact _self;
  final $Res Function(Pact) _then;

/// Create a copy of Pact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? cadence = null,Object? durationTrials = null,Object? startDate = null,Object? endDate = null,Object? status = null,Object? createdAt = null,Object? ifCondition = freezed,Object? thenAction = freezed,Object? hypothesis = freezed,Object? temperature = freezed,Object? reflectionIntervalTrials = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as PactCadence,durationTrials: null == durationTrials ? _self.durationTrials : durationTrials // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PactStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ifCondition: freezed == ifCondition ? _self.ifCondition : ifCondition // ignore: cast_nullable_to_non_nullable
as String?,thenAction: freezed == thenAction ? _self.thenAction : thenAction // ignore: cast_nullable_to_non_nullable
as String?,hypothesis: freezed == hypothesis ? _self.hypothesis : hypothesis // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as CuriosityTemperature?,reflectionIntervalTrials: freezed == reflectionIntervalTrials ? _self.reflectionIntervalTrials : reflectionIntervalTrials // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Pact].
extension PactPatterns on Pact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pact value)  $default,){
final _that = this;
switch (_that) {
case _Pact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pact value)?  $default,){
final _that = this;
switch (_that) {
case _Pact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String action,  PactCadence cadence,  int durationTrials,  DateTime startDate,  DateTime endDate,  PactStatus status,  DateTime createdAt,  String? ifCondition,  String? thenAction,  String? hypothesis,  CuriosityTemperature? temperature,  int? reflectionIntervalTrials)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pact() when $default != null:
return $default(_that.id,_that.action,_that.cadence,_that.durationTrials,_that.startDate,_that.endDate,_that.status,_that.createdAt,_that.ifCondition,_that.thenAction,_that.hypothesis,_that.temperature,_that.reflectionIntervalTrials);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String action,  PactCadence cadence,  int durationTrials,  DateTime startDate,  DateTime endDate,  PactStatus status,  DateTime createdAt,  String? ifCondition,  String? thenAction,  String? hypothesis,  CuriosityTemperature? temperature,  int? reflectionIntervalTrials)  $default,) {final _that = this;
switch (_that) {
case _Pact():
return $default(_that.id,_that.action,_that.cadence,_that.durationTrials,_that.startDate,_that.endDate,_that.status,_that.createdAt,_that.ifCondition,_that.thenAction,_that.hypothesis,_that.temperature,_that.reflectionIntervalTrials);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String action,  PactCadence cadence,  int durationTrials,  DateTime startDate,  DateTime endDate,  PactStatus status,  DateTime createdAt,  String? ifCondition,  String? thenAction,  String? hypothesis,  CuriosityTemperature? temperature,  int? reflectionIntervalTrials)?  $default,) {final _that = this;
switch (_that) {
case _Pact() when $default != null:
return $default(_that.id,_that.action,_that.cadence,_that.durationTrials,_that.startDate,_that.endDate,_that.status,_that.createdAt,_that.ifCondition,_that.thenAction,_that.hypothesis,_that.temperature,_that.reflectionIntervalTrials);case _:
  return null;

}
}

}

/// @nodoc


class _Pact implements Pact {
  const _Pact({required this.id, required this.action, required this.cadence, required this.durationTrials, required this.startDate, required this.endDate, required this.status, required this.createdAt, this.ifCondition, this.thenAction, this.hypothesis, this.temperature, this.reflectionIntervalTrials});
  

@override final  String id;
// UUID
@override final  String action;
// "I will <action>"
@override final  PactCadence cadence;
// daily | weekly | biweekly
@override final  int durationTrials;
// total number of trials committed to
@override final  DateTime startDate;
@override final  DateTime endDate;
// derived: startDate + trials × cadence
@override final  PactStatus status;
// active | paused | completed | abandoned
@override final  DateTime createdAt;
@override final  String? ifCondition;
// "If <trigger>..."
@override final  String? thenAction;
// "...then <action>"
@override final  String? hypothesis;
// the user's stated curiosity or hypothesis
@override final  CuriosityTemperature? temperature;
// cold | warm | fiery
@override final  int? reflectionIntervalTrials;

/// Create a copy of Pact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PactCopyWith<_Pact> get copyWith => __$PactCopyWithImpl<_Pact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pact&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.durationTrials, durationTrials) || other.durationTrials == durationTrials)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ifCondition, ifCondition) || other.ifCondition == ifCondition)&&(identical(other.thenAction, thenAction) || other.thenAction == thenAction)&&(identical(other.hypothesis, hypothesis) || other.hypothesis == hypothesis)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.reflectionIntervalTrials, reflectionIntervalTrials) || other.reflectionIntervalTrials == reflectionIntervalTrials));
}


@override
int get hashCode => Object.hash(runtimeType,id,action,cadence,durationTrials,startDate,endDate,status,createdAt,ifCondition,thenAction,hypothesis,temperature,reflectionIntervalTrials);

@override
String toString() {
  return 'Pact(id: $id, action: $action, cadence: $cadence, durationTrials: $durationTrials, startDate: $startDate, endDate: $endDate, status: $status, createdAt: $createdAt, ifCondition: $ifCondition, thenAction: $thenAction, hypothesis: $hypothesis, temperature: $temperature, reflectionIntervalTrials: $reflectionIntervalTrials)';
}


}

/// @nodoc
abstract mixin class _$PactCopyWith<$Res> implements $PactCopyWith<$Res> {
  factory _$PactCopyWith(_Pact value, $Res Function(_Pact) _then) = __$PactCopyWithImpl;
@override @useResult
$Res call({
 String id, String action, PactCadence cadence, int durationTrials, DateTime startDate, DateTime endDate, PactStatus status, DateTime createdAt, String? ifCondition, String? thenAction, String? hypothesis, CuriosityTemperature? temperature, int? reflectionIntervalTrials
});




}
/// @nodoc
class __$PactCopyWithImpl<$Res>
    implements _$PactCopyWith<$Res> {
  __$PactCopyWithImpl(this._self, this._then);

  final _Pact _self;
  final $Res Function(_Pact) _then;

/// Create a copy of Pact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? cadence = null,Object? durationTrials = null,Object? startDate = null,Object? endDate = null,Object? status = null,Object? createdAt = null,Object? ifCondition = freezed,Object? thenAction = freezed,Object? hypothesis = freezed,Object? temperature = freezed,Object? reflectionIntervalTrials = freezed,}) {
  return _then(_Pact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as PactCadence,durationTrials: null == durationTrials ? _self.durationTrials : durationTrials // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PactStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ifCondition: freezed == ifCondition ? _self.ifCondition : ifCondition // ignore: cast_nullable_to_non_nullable
as String?,thenAction: freezed == thenAction ? _self.thenAction : thenAction // ignore: cast_nullable_to_non_nullable
as String?,hypothesis: freezed == hypothesis ? _self.hypothesis : hypothesis // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as CuriosityTemperature?,reflectionIntervalTrials: freezed == reflectionIntervalTrials ? _self.reflectionIntervalTrials : reflectionIntervalTrials // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
