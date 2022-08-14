// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Check _$CheckFromJson(Map<String, dynamic> json) {
  return _Check.fromJson(json);
}

/// @nodoc
mixin _$Check {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckCopyWith<Check> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckCopyWith<$Res> {
  factory $CheckCopyWith(Check value, $Res Function(Check) then) =
      _$CheckCopyWithImpl<$Res>;
  $Res call({dynamic id, String name, bool isChecked});
}

/// @nodoc
class _$CheckCopyWithImpl<$Res> implements $CheckCopyWith<$Res> {
  _$CheckCopyWithImpl(this._value, this._then);

  final Check _value;
  // ignore: unused_field
  final $Res Function(Check) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isChecked = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: isChecked == freezed
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_CheckCopyWith<$Res> implements $CheckCopyWith<$Res> {
  factory _$$_CheckCopyWith(_$_Check value, $Res Function(_$_Check) then) =
      __$$_CheckCopyWithImpl<$Res>;
  @override
  $Res call({dynamic id, String name, bool isChecked});
}

/// @nodoc
class __$$_CheckCopyWithImpl<$Res> extends _$CheckCopyWithImpl<$Res>
    implements _$$_CheckCopyWith<$Res> {
  __$$_CheckCopyWithImpl(_$_Check _value, $Res Function(_$_Check) _then)
      : super(_value, (v) => _then(v as _$_Check));

  @override
  _$_Check get _value => super._value as _$_Check;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isChecked = freezed,
  }) {
    return _then(_$_Check(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: isChecked == freezed
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Check implements _Check {
  const _$_Check(
      {required this.id, required this.name, required this.isChecked});

  factory _$_Check.fromJson(Map<String, dynamic> json) =>
      _$$_CheckFromJson(json);

  @override
  final dynamic id;
  @override
  final String name;
  @override
  final bool isChecked;

  @override
  String toString() {
    return 'Check(id: $id, name: $name, isChecked: $isChecked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Check &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.isChecked, isChecked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isChecked));

  @JsonKey(ignore: true)
  @override
  _$$_CheckCopyWith<_$_Check> get copyWith =>
      __$$_CheckCopyWithImpl<_$_Check>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckToJson(
      this,
    );
  }
}

abstract class _Check implements Check {
  const factory _Check(
      {required final dynamic id,
      required final String name,
      required final bool isChecked}) = _$_Check;

  factory _Check.fromJson(Map<String, dynamic> json) = _$_Check.fromJson;

  @override
  dynamic get id;
  @override
  String get name;
  @override
  bool get isChecked;
  @override
  @JsonKey(ignore: true)
  _$$_CheckCopyWith<_$_Check> get copyWith =>
      throw _privateConstructorUsedError;
}
