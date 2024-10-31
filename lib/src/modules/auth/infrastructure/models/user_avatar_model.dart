import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_avatar_model.freezed.dart';
part 'user_avatar_model.g.dart';

@freezed
class UserAvatarModel with _$UserAvatarModel implements UserAvatar {
  const UserAvatarModel._();

  const factory UserAvatarModel({
    @Default('') String filePath,
  }) = _UserAvatarModel;

  factory UserAvatarModel.fromJson(Map<String, dynamic> json) =>
      _$UserAvatarModelFromJson(json);
}
