// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
class _$UserModelTearOff {
  const _$UserModelTearOff();

  _UserModel call(
      {String? status,
      bool? presence,
      List<dynamic>? chats,
      String id = '',
      List<dynamic>? stories,
      bool? isLocationEnabled,
      List<dynamic>? following,
      List<dynamic>? followers,
      String username = '',
      String? profilePic = defaultProfilePic,
      String? coverPhoto = defaultCoverPhoto,
      String? bitmapImage = defaultBitmapImage,
      Map<String, dynamic>? location = defautLocation}) {
    return _UserModel(
      status: status,
      presence: presence,
      chats: chats,
      id: id,
      stories: stories,
      isLocationEnabled: isLocationEnabled,
      following: following,
      followers: followers,
      username: username,
      profilePic: profilePic,
      coverPhoto: coverPhoto,
      bitmapImage: bitmapImage,
      location: location,
    );
  }

  UserModel fromJson(Map<String, Object?> json) {
    return UserModel.fromJson(json);
  }
}

/// @nodoc
const $UserModel = _$UserModelTearOff();

/// @nodoc
mixin _$UserModel {
  String? get status => throw _privateConstructorUsedError;
  bool? get presence => throw _privateConstructorUsedError;
  List<dynamic>? get chats => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<dynamic>? get stories => throw _privateConstructorUsedError;
  bool? get isLocationEnabled => throw _privateConstructorUsedError;
  List<dynamic>? get following => throw _privateConstructorUsedError;
  List<dynamic>? get followers => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get profilePic => throw _privateConstructorUsedError;
  String? get coverPhoto => throw _privateConstructorUsedError;
  String? get bitmapImage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String? status,
      bool? presence,
      List<dynamic>? chats,
      String id,
      List<dynamic>? stories,
      bool? isLocationEnabled,
      List<dynamic>? following,
      List<dynamic>? followers,
      String username,
      String? profilePic,
      String? coverPhoto,
      String? bitmapImage,
      Map<String, dynamic>? location});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? presence = freezed,
    Object? chats = freezed,
    Object? id = freezed,
    Object? stories = freezed,
    Object? isLocationEnabled = freezed,
    Object? following = freezed,
    Object? followers = freezed,
    Object? username = freezed,
    Object? profilePic = freezed,
    Object? coverPhoto = freezed,
    Object? bitmapImage = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      presence: presence == freezed
          ? _value.presence
          : presence // ignore: cast_nullable_to_non_nullable
              as bool?,
      chats: chats == freezed
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stories: stories == freezed
          ? _value.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      isLocationEnabled: isLocationEnabled == freezed
          ? _value.isLocationEnabled
          : isLocationEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      followers: followers == freezed
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profilePic: profilePic == freezed
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as String?,
      coverPhoto: coverPhoto == freezed
          ? _value.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      bitmapImage: bitmapImage == freezed
          ? _value.bitmapImage
          : bitmapImage // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) then) =
      __$UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? status,
      bool? presence,
      List<dynamic>? chats,
      String id,
      List<dynamic>? stories,
      bool? isLocationEnabled,
      List<dynamic>? following,
      List<dynamic>? followers,
      String username,
      String? profilePic,
      String? coverPhoto,
      String? bitmapImage,
      Map<String, dynamic>? location});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(_UserModel _value, $Res Function(_UserModel) _then)
      : super(_value, (v) => _then(v as _UserModel));

  @override
  _UserModel get _value => super._value as _UserModel;

  @override
  $Res call({
    Object? status = freezed,
    Object? presence = freezed,
    Object? chats = freezed,
    Object? id = freezed,
    Object? stories = freezed,
    Object? isLocationEnabled = freezed,
    Object? following = freezed,
    Object? followers = freezed,
    Object? username = freezed,
    Object? profilePic = freezed,
    Object? coverPhoto = freezed,
    Object? bitmapImage = freezed,
    Object? location = freezed,
  }) {
    return _then(_UserModel(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      presence: presence == freezed
          ? _value.presence
          : presence // ignore: cast_nullable_to_non_nullable
              as bool?,
      chats: chats == freezed
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stories: stories == freezed
          ? _value.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      isLocationEnabled: isLocationEnabled == freezed
          ? _value.isLocationEnabled
          : isLocationEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      followers: followers == freezed
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profilePic: profilePic == freezed
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as String?,
      coverPhoto: coverPhoto == freezed
          ? _value.coverPhoto
          : coverPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      bitmapImage: bitmapImage == freezed
          ? _value.bitmapImage
          : bitmapImage // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  const _$_UserModel(
      {this.status,
      this.presence,
      this.chats,
      this.id = '',
      this.stories,
      this.isLocationEnabled,
      this.following,
      this.followers,
      this.username = '',
      this.profilePic = defaultProfilePic,
      this.coverPhoto = defaultCoverPhoto,
      this.bitmapImage = defaultBitmapImage,
      this.location = defautLocation});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String? status;
  @override
  final bool? presence;
  @override
  final List<dynamic>? chats;
  @JsonKey()
  @override
  final String id;
  @override
  final List<dynamic>? stories;
  @override
  final bool? isLocationEnabled;
  @override
  final List<dynamic>? following;
  @override
  final List<dynamic>? followers;
  @JsonKey()
  @override
  final String username;
  @JsonKey()
  @override
  final String? profilePic;
  @JsonKey()
  @override
  final String? coverPhoto;
  @JsonKey()
  @override
  final String? bitmapImage;
  @JsonKey()
  @override
  final Map<String, dynamic>? location;

  @override
  String toString() {
    return 'UserModel(status: $status, presence: $presence, chats: $chats, id: $id, stories: $stories, isLocationEnabled: $isLocationEnabled, following: $following, followers: $followers, username: $username, profilePic: $profilePic, coverPhoto: $coverPhoto, bitmapImage: $bitmapImage, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.presence, presence) &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.stories, stories) &&
            const DeepCollectionEquality()
                .equals(other.isLocationEnabled, isLocationEnabled) &&
            const DeepCollectionEquality().equals(other.following, following) &&
            const DeepCollectionEquality().equals(other.followers, followers) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality()
                .equals(other.profilePic, profilePic) &&
            const DeepCollectionEquality()
                .equals(other.coverPhoto, coverPhoto) &&
            const DeepCollectionEquality()
                .equals(other.bitmapImage, bitmapImage) &&
            const DeepCollectionEquality().equals(other.location, location));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(presence),
      const DeepCollectionEquality().hash(chats),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(stories),
      const DeepCollectionEquality().hash(isLocationEnabled),
      const DeepCollectionEquality().hash(following),
      const DeepCollectionEquality().hash(followers),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(profilePic),
      const DeepCollectionEquality().hash(coverPhoto),
      const DeepCollectionEquality().hash(bitmapImage),
      const DeepCollectionEquality().hash(location));

  @JsonKey(ignore: true)
  @override
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {String? status,
      bool? presence,
      List<dynamic>? chats,
      String id,
      List<dynamic>? stories,
      bool? isLocationEnabled,
      List<dynamic>? following,
      List<dynamic>? followers,
      String username,
      String? profilePic,
      String? coverPhoto,
      String? bitmapImage,
      Map<String, dynamic>? location}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String? get status;
  @override
  bool? get presence;
  @override
  List<dynamic>? get chats;
  @override
  String get id;
  @override
  List<dynamic>? get stories;
  @override
  bool? get isLocationEnabled;
  @override
  List<dynamic>? get following;
  @override
  List<dynamic>? get followers;
  @override
  String get username;
  @override
  String? get profilePic;
  @override
  String? get coverPhoto;
  @override
  String? get bitmapImage;
  @override
  Map<String, dynamic>? get location;
  @override
  @JsonKey(ignore: true)
  _$UserModelCopyWith<_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}