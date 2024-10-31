import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
import 'user_avatar_model.dart';
import 'user_background_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel implements User {
  const UserModel._();

  const factory UserModel({
    @Default(0) int id,
    @Default('') String fullname,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String accessToken,
    @Default(0) int balance,
    @Default(0) int pendingBalance,
    @Default(UserAvatarModel()) UserAvatarModel avatar,
    @Default(UserBackgroundModel()) UserBackgroundModel background,
    @Default([]) List<int> follower,
    @Default([]) List<int> following,
    @Default(0) double review,
    @Default(0) int sold,
    @Default(0) int selling,
    @Default(0) int participatedDays,
    @Default([]) List<int> favouriteProducts,
  }) = _UserModel;

  factory UserModel.fromJson(dynamic json) => _$UserModelFromJson(json);
}
