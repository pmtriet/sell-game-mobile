import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_background_model.freezed.dart';
part 'user_background_model.g.dart';

@freezed
class UserBackgroundModel with _$UserBackgroundModel implements UserBackground {
  const UserBackgroundModel._();

  const factory UserBackgroundModel({
    @Default('') String filePath,
  }) = _UserBackgroundModel;

  factory UserBackgroundModel.fromJson(Map<String, dynamic> json) =>
      _$UserBackgroundModelFromJson(json);
}