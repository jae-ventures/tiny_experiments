// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reflection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Reflection {

 String get id;// UUID
 String get pactId; int get sessionNumber;// mirrors the session of the current trial run
 ReflectionKind get kind;// informal | formal
 DateTime get loggedAt;// when this reflection was recorded
 DateTime get createdAt; CuriosityTemperature? get temperature;// cold | warm | fiery (the spectrum rating)
 String? get note;// free-text (supports +/−/→ template)
 String? get intention;// optional: "I want to try..." — a lightweight course correction
 ReflectionDecision? get decision;// persist | pause | pivot (formal only)
 String? get decisionNote;// context on the decision (formal only)
 String? get linkedTrialId;
/// Create a copy of Reflection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReflectionCopyWith<Reflection> get copyWith => _$ReflectionCopyWithImpl<Reflection>(this as Reflection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reflection&&(identical(other.id, id) || other.id == id)&&(identical(other.pactId, pactId) || other.pactId == pactId)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.loggedAt, loggedAt) || other.loggedAt == loggedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.note, note) || other.note == note)&&(identical(other.intention, intention) || other.intention == intention)&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.decisionNote, decisionNote) || other.decisionNote == decisionNote)&&(identical(other.linkedTrialId, linkedTrialId) || other.linkedTrialId == linkedTrialId));
}


@override
int get hashCode => Object.hash(runtimeType,id,pactId,sessionNumber,kind,loggedAt,createdAt,temperature,note,intention,decision,decisionNote,linkedTrialId);

@override
String toString() {
  return 'Reflection(id: $id, pactId: $pactId, sessionNumber: $sessionNumber, kind: $kind, loggedAt: $loggedAt, createdAt: $createdAt, temperature: $temperature, note: $note, intention: $intention, decision: $decision, decisionNote: $decisionNote, linkedTrialId: $linkedTrialId)';
}


}

/// @nodoc
abstract mixin class $ReflectionCopyWith<$Res>  {
  factory $ReflectionCopyWith(Reflection value, $Res Function(Reflection) _then) = _$ReflectionCopyWithImpl;
@useResult
$Res call({
 String id, String pactId, int sessionNumber, ReflectionKind kind, DateTime loggedAt, DateTime createdAt, CuriosityTemperature? temperature, String? note, String? intention, ReflectionDecision? decision, String? decisionNote, String? linkedTrialId
});




}
/// @nodoc
class _$ReflectionCopyWithImpl<$Res>
    implements $ReflectionCopyWith<$Res> {
  _$ReflectionCopyWithImpl(this._self, this._then);

  final Reflection _self;
  final $Res Function(Reflection) _then;

/// Create a copy of Reflection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pactId = null,Object? sessionNumber = null,Object? kind = null,Object? loggedAt = null,Object? createdAt = null,Object? temperature = freezed,Object? note = freezed,Object? intention = freezed,Object? decision = freezed,Object? decisionNote = freezed,Object? linkedTrialId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pactId: null == pactId ? _self.pactId : pactId // ignore: cast_nullable_to_non_nullable
as String,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReflectionKind,loggedAt: null == loggedAt ? _self.loggedAt : loggedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as CuriosityTemperature?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,intention: freezed == intention ? _self.intention : intention // ignore: cast_nullable_to_non_nullable
as String?,decision: freezed == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as ReflectionDecision?,decisionNote: freezed == decisionNote ? _self.decisionNote : decisionNote // ignore: cast_nullable_to_non_nullable
as String?,linkedTrialId: freezed == linkedTrialId ? _self.linkedTrialId : linkedTrialId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Reflection].
extension ReflectionPatterns on Reflection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reflection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reflection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reflection value)  $default,){
final _that = this;
switch (_that) {
case _Reflection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reflection value)?  $default,){
final _that = this;
switch (_that) {
case _Reflection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String pactId,  int sessionNumber,  ReflectionKind kind,  DateTime loggedAt,  DateTime createdAt,  CuriosityTemperature? temperature,  String? note,  String? intention,  ReflectionDecision? decision,  String? decisionNote,  String? linkedTrialId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reflection() when $default != null:
return $default(_that.id,_that.pactId,_that.sessionNumber,_that.kind,_that.loggedAt,_that.createdAt,_that.temperature,_that.note,_that.intention,_that.decision,_that.decisionNote,_that.linkedTrialId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String pactId,  int sessionNumber,  ReflectionKind kind,  DateTime loggedAt,  DateTime createdAt,  CuriosityTemperature? temperature,  String? note,  String? intention,  ReflectionDecision? decision,  String? decisionNote,  String? linkedTrialId)  $default,) {final _that = this;
switch (_that) {
case _Reflection():
return $default(_that.id,_that.pactId,_that.sessionNumber,_that.kind,_that.loggedAt,_that.createdAt,_that.temperature,_that.note,_that.intention,_that.decision,_that.decisionNote,_that.linkedTrialId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String pactId,  int sessionNumber,  ReflectionKind kind,  DateTime loggedAt,  DateTime createdAt,  CuriosityTemperature? temperature,  String? note,  String? intention,  ReflectionDecision? decision,  String? decisionNote,  String? linkedTrialId)?  $default,) {final _that = this;
switch (_that) {
case _Reflection() when $default != null:
return $default(_that.id,_that.pactId,_that.sessionNumber,_that.kind,_that.loggedAt,_that.createdAt,_that.temperature,_that.note,_that.intention,_that.decision,_that.decisionNote,_that.linkedTrialId);case _:
  return null;

}
}

}

/// @nodoc


class _Reflection implements Reflection {
  const _Reflection({required this.id, required this.pactId, required this.sessionNumber, required this.kind, required this.loggedAt, required this.createdAt, this.temperature, this.note, this.intention, this.decision, this.decisionNote, this.linkedTrialId});
  

@override final  String id;
// UUID
@override final  String pactId;
@override final  int sessionNumber;
// mirrors the session of the current trial run
@override final  ReflectionKind kind;
// informal | formal
@override final  DateTime loggedAt;
// when this reflection was recorded
@override final  DateTime createdAt;
@override final  CuriosityTemperature? temperature;
// cold | warm | fiery (the spectrum rating)
@override final  String? note;
// free-text (supports +/−/→ template)
@override final  String? intention;
// optional: "I want to try..." — a lightweight course correction
@override final  ReflectionDecision? decision;
// persist | pause | pivot (formal only)
@override final  String? decisionNote;
// context on the decision (formal only)
@override final  String? linkedTrialId;

/// Create a copy of Reflection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReflectionCopyWith<_Reflection> get copyWith => __$ReflectionCopyWithImpl<_Reflection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reflection&&(identical(other.id, id) || other.id == id)&&(identical(other.pactId, pactId) || other.pactId == pactId)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.loggedAt, loggedAt) || other.loggedAt == loggedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.note, note) || other.note == note)&&(identical(other.intention, intention) || other.intention == intention)&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.decisionNote, decisionNote) || other.decisionNote == decisionNote)&&(identical(other.linkedTrialId, linkedTrialId) || other.linkedTrialId == linkedTrialId));
}


@override
int get hashCode => Object.hash(runtimeType,id,pactId,sessionNumber,kind,loggedAt,createdAt,temperature,note,intention,decision,decisionNote,linkedTrialId);

@override
String toString() {
  return 'Reflection(id: $id, pactId: $pactId, sessionNumber: $sessionNumber, kind: $kind, loggedAt: $loggedAt, createdAt: $createdAt, temperature: $temperature, note: $note, intention: $intention, decision: $decision, decisionNote: $decisionNote, linkedTrialId: $linkedTrialId)';
}


}

/// @nodoc
abstract mixin class _$ReflectionCopyWith<$Res> implements $ReflectionCopyWith<$Res> {
  factory _$ReflectionCopyWith(_Reflection value, $Res Function(_Reflection) _then) = __$ReflectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String pactId, int sessionNumber, ReflectionKind kind, DateTime loggedAt, DateTime createdAt, CuriosityTemperature? temperature, String? note, String? intention, ReflectionDecision? decision, String? decisionNote, String? linkedTrialId
});




}
/// @nodoc
class __$ReflectionCopyWithImpl<$Res>
    implements _$ReflectionCopyWith<$Res> {
  __$ReflectionCopyWithImpl(this._self, this._then);

  final _Reflection _self;
  final $Res Function(_Reflection) _then;

/// Create a copy of Reflection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pactId = null,Object? sessionNumber = null,Object? kind = null,Object? loggedAt = null,Object? createdAt = null,Object? temperature = freezed,Object? note = freezed,Object? intention = freezed,Object? decision = freezed,Object? decisionNote = freezed,Object? linkedTrialId = freezed,}) {
  return _then(_Reflection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pactId: null == pactId ? _self.pactId : pactId // ignore: cast_nullable_to_non_nullable
as String,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReflectionKind,loggedAt: null == loggedAt ? _self.loggedAt : loggedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as CuriosityTemperature?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,intention: freezed == intention ? _self.intention : intention // ignore: cast_nullable_to_non_nullable
as String?,decision: freezed == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as ReflectionDecision?,decisionNote: freezed == decisionNote ? _self.decisionNote : decisionNote // ignore: cast_nullable_to_non_nullable
as String?,linkedTrialId: freezed == linkedTrialId ? _self.linkedTrialId : linkedTrialId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
