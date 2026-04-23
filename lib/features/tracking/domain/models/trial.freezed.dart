// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trial.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Trial {

 String get id;// UUID
 String get pactId; int get sessionNumber;// 1 = original, 2 = first resume, etc.
 int get sequenceIndex;// position in full trial schedule (1-based)
 DateTime get scheduledDate;// immutable ground truth for this trial slot
 TrialStatus get status;// pending | completed | skipped | late
 DateTime get createdAt;// when this trial record was generated
 DateTime? get completedAt;// when the user actually logged it (may differ from scheduledDate)
 String? get note;
/// Create a copy of Trial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrialCopyWith<Trial> get copyWith => _$TrialCopyWithImpl<Trial>(this as Trial, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trial&&(identical(other.id, id) || other.id == id)&&(identical(other.pactId, pactId) || other.pactId == pactId)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.sequenceIndex, sequenceIndex) || other.sequenceIndex == sequenceIndex)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,pactId,sessionNumber,sequenceIndex,scheduledDate,status,createdAt,completedAt,note);

@override
String toString() {
  return 'Trial(id: $id, pactId: $pactId, sessionNumber: $sessionNumber, sequenceIndex: $sequenceIndex, scheduledDate: $scheduledDate, status: $status, createdAt: $createdAt, completedAt: $completedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class $TrialCopyWith<$Res>  {
  factory $TrialCopyWith(Trial value, $Res Function(Trial) _then) = _$TrialCopyWithImpl;
@useResult
$Res call({
 String id, String pactId, int sessionNumber, int sequenceIndex, DateTime scheduledDate, TrialStatus status, DateTime createdAt, DateTime? completedAt, String? note
});




}
/// @nodoc
class _$TrialCopyWithImpl<$Res>
    implements $TrialCopyWith<$Res> {
  _$TrialCopyWithImpl(this._self, this._then);

  final Trial _self;
  final $Res Function(Trial) _then;

/// Create a copy of Trial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pactId = null,Object? sessionNumber = null,Object? sequenceIndex = null,Object? scheduledDate = null,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pactId: null == pactId ? _self.pactId : pactId // ignore: cast_nullable_to_non_nullable
as String,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,sequenceIndex: null == sequenceIndex ? _self.sequenceIndex : sequenceIndex // ignore: cast_nullable_to_non_nullable
as int,scheduledDate: null == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrialStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Trial].
extension TrialPatterns on Trial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trial value)  $default,){
final _that = this;
switch (_that) {
case _Trial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trial value)?  $default,){
final _that = this;
switch (_that) {
case _Trial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String pactId,  int sessionNumber,  int sequenceIndex,  DateTime scheduledDate,  TrialStatus status,  DateTime createdAt,  DateTime? completedAt,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trial() when $default != null:
return $default(_that.id,_that.pactId,_that.sessionNumber,_that.sequenceIndex,_that.scheduledDate,_that.status,_that.createdAt,_that.completedAt,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String pactId,  int sessionNumber,  int sequenceIndex,  DateTime scheduledDate,  TrialStatus status,  DateTime createdAt,  DateTime? completedAt,  String? note)  $default,) {final _that = this;
switch (_that) {
case _Trial():
return $default(_that.id,_that.pactId,_that.sessionNumber,_that.sequenceIndex,_that.scheduledDate,_that.status,_that.createdAt,_that.completedAt,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String pactId,  int sessionNumber,  int sequenceIndex,  DateTime scheduledDate,  TrialStatus status,  DateTime createdAt,  DateTime? completedAt,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _Trial() when $default != null:
return $default(_that.id,_that.pactId,_that.sessionNumber,_that.sequenceIndex,_that.scheduledDate,_that.status,_that.createdAt,_that.completedAt,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Trial implements Trial {
  const _Trial({required this.id, required this.pactId, required this.sessionNumber, required this.sequenceIndex, required this.scheduledDate, required this.status, required this.createdAt, this.completedAt, this.note});
  

@override final  String id;
// UUID
@override final  String pactId;
@override final  int sessionNumber;
// 1 = original, 2 = first resume, etc.
@override final  int sequenceIndex;
// position in full trial schedule (1-based)
@override final  DateTime scheduledDate;
// immutable ground truth for this trial slot
@override final  TrialStatus status;
// pending | completed | skipped | late
@override final  DateTime createdAt;
// when this trial record was generated
@override final  DateTime? completedAt;
// when the user actually logged it (may differ from scheduledDate)
@override final  String? note;

/// Create a copy of Trial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrialCopyWith<_Trial> get copyWith => __$TrialCopyWithImpl<_Trial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trial&&(identical(other.id, id) || other.id == id)&&(identical(other.pactId, pactId) || other.pactId == pactId)&&(identical(other.sessionNumber, sessionNumber) || other.sessionNumber == sessionNumber)&&(identical(other.sequenceIndex, sequenceIndex) || other.sequenceIndex == sequenceIndex)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,pactId,sessionNumber,sequenceIndex,scheduledDate,status,createdAt,completedAt,note);

@override
String toString() {
  return 'Trial(id: $id, pactId: $pactId, sessionNumber: $sessionNumber, sequenceIndex: $sequenceIndex, scheduledDate: $scheduledDate, status: $status, createdAt: $createdAt, completedAt: $completedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TrialCopyWith<$Res> implements $TrialCopyWith<$Res> {
  factory _$TrialCopyWith(_Trial value, $Res Function(_Trial) _then) = __$TrialCopyWithImpl;
@override @useResult
$Res call({
 String id, String pactId, int sessionNumber, int sequenceIndex, DateTime scheduledDate, TrialStatus status, DateTime createdAt, DateTime? completedAt, String? note
});




}
/// @nodoc
class __$TrialCopyWithImpl<$Res>
    implements _$TrialCopyWith<$Res> {
  __$TrialCopyWithImpl(this._self, this._then);

  final _Trial _self;
  final $Res Function(_Trial) _then;

/// Create a copy of Trial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pactId = null,Object? sessionNumber = null,Object? sequenceIndex = null,Object? scheduledDate = null,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,Object? note = freezed,}) {
  return _then(_Trial(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pactId: null == pactId ? _self.pactId : pactId // ignore: cast_nullable_to_non_nullable
as String,sessionNumber: null == sessionNumber ? _self.sessionNumber : sessionNumber // ignore: cast_nullable_to_non_nullable
as int,sequenceIndex: null == sequenceIndex ? _self.sequenceIndex : sequenceIndex // ignore: cast_nullable_to_non_nullable
as int,scheduledDate: null == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrialStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
