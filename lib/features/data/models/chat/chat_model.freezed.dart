// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
class _$ChatModelTearOff {
  const _$ChatModelTearOff();

  _ChatModel call(
      {required String id,
      required int dateUpdated,
      required List<String> typing,
      required Map<String, dynamic> unread,
      required List<dynamic> participants,
      LatestMessage? latestMessage = null}) {
    return _ChatModel(
      id: id,
      dateUpdated: dateUpdated,
      typing: typing,
      unread: unread,
      participants: participants,
      latestMessage: latestMessage,
    );
  }

  ChatModel fromJson(Map<String, Object?> json) {
    return ChatModel.fromJson(json);
  }
}

/// @nodoc
const $ChatModel = _$ChatModelTearOff();

/// @nodoc
mixin _$ChatModel {
  String get id => throw _privateConstructorUsedError;
  int get dateUpdated => throw _privateConstructorUsedError;
  List<String> get typing => throw _privateConstructorUsedError;
  Map<String, dynamic> get unread => throw _privateConstructorUsedError;
  List<dynamic> get participants => throw _privateConstructorUsedError;
  LatestMessage? get latestMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      int dateUpdated,
      List<String> typing,
      Map<String, dynamic> unread,
      List<dynamic> participants,
      LatestMessage? latestMessage});

  $LatestMessageCopyWith<$Res>? get latestMessage;
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res> implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  final ChatModel _value;
  // ignore: unused_field
  final $Res Function(ChatModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? dateUpdated = freezed,
    Object? typing = freezed,
    Object? unread = freezed,
    Object? participants = freezed,
    Object? latestMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dateUpdated: dateUpdated == freezed
          ? _value.dateUpdated
          : dateUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      typing: typing == freezed
          ? _value.typing
          : typing // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unread: unread == freezed
          ? _value.unread
          : unread // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      participants: participants == freezed
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      latestMessage: latestMessage == freezed
          ? _value.latestMessage
          : latestMessage // ignore: cast_nullable_to_non_nullable
              as LatestMessage?,
    ));
  }

  @override
  $LatestMessageCopyWith<$Res>? get latestMessage {
    if (_value.latestMessage == null) {
      return null;
    }

    return $LatestMessageCopyWith<$Res>(_value.latestMessage!, (value) {
      return _then(_value.copyWith(latestMessage: value));
    });
  }
}

/// @nodoc
abstract class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(
          _ChatModel value, $Res Function(_ChatModel) then) =
      __$ChatModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      int dateUpdated,
      List<String> typing,
      Map<String, dynamic> unread,
      List<dynamic> participants,
      LatestMessage? latestMessage});

  @override
  $LatestMessageCopyWith<$Res>? get latestMessage;
}

/// @nodoc
class __$ChatModelCopyWithImpl<$Res> extends _$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(_ChatModel _value, $Res Function(_ChatModel) _then)
      : super(_value, (v) => _then(v as _ChatModel));

  @override
  _ChatModel get _value => super._value as _ChatModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? dateUpdated = freezed,
    Object? typing = freezed,
    Object? unread = freezed,
    Object? participants = freezed,
    Object? latestMessage = freezed,
  }) {
    return _then(_ChatModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dateUpdated: dateUpdated == freezed
          ? _value.dateUpdated
          : dateUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      typing: typing == freezed
          ? _value.typing
          : typing // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unread: unread == freezed
          ? _value.unread
          : unread // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      participants: participants == freezed
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      latestMessage: latestMessage == freezed
          ? _value.latestMessage
          : latestMessage // ignore: cast_nullable_to_non_nullable
              as LatestMessage?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatModel implements _ChatModel {
  const _$_ChatModel(
      {required this.id,
      required this.dateUpdated,
      required this.typing,
      required this.unread,
      required this.participants,
      this.latestMessage = null});

  factory _$_ChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatModelFromJson(json);

  @override
  final String id;
  @override
  final int dateUpdated;
  @override
  final List<String> typing;
  @override
  final Map<String, dynamic> unread;
  @override
  final List<dynamic> participants;
  @JsonKey()
  @override
  final LatestMessage? latestMessage;

  @override
  String toString() {
    return 'ChatModel(id: $id, dateUpdated: $dateUpdated, typing: $typing, unread: $unread, participants: $participants, latestMessage: $latestMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.dateUpdated, dateUpdated) &&
            const DeepCollectionEquality().equals(other.typing, typing) &&
            const DeepCollectionEquality().equals(other.unread, unread) &&
            const DeepCollectionEquality()
                .equals(other.participants, participants) &&
            const DeepCollectionEquality()
                .equals(other.latestMessage, latestMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(dateUpdated),
      const DeepCollectionEquality().hash(typing),
      const DeepCollectionEquality().hash(unread),
      const DeepCollectionEquality().hash(participants),
      const DeepCollectionEquality().hash(latestMessage));

  @JsonKey(ignore: true)
  @override
  _$ChatModelCopyWith<_ChatModel> get copyWith =>
      __$ChatModelCopyWithImpl<_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatModelToJson(this);
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {required String id,
      required int dateUpdated,
      required List<String> typing,
      required Map<String, dynamic> unread,
      required List<dynamic> participants,
      LatestMessage? latestMessage}) = _$_ChatModel;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$_ChatModel.fromJson;

  @override
  String get id;
  @override
  int get dateUpdated;
  @override
  List<String> get typing;
  @override
  Map<String, dynamic> get unread;
  @override
  List<dynamic> get participants;
  @override
  LatestMessage? get latestMessage;
  @override
  @JsonKey(ignore: true)
  _$ChatModelCopyWith<_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
