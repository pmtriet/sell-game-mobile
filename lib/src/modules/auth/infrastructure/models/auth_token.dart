import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_token.freezed.dart';
part 'auth_token.g.dart';


@freezed
class AuthToken with _$AuthToken {
  const AuthToken._();

  const factory AuthToken({
    String? accessToken,
    String? refreshToken,
  }) = _AuthToken;

  factory AuthToken.fromJson(dynamic json) => _$AuthTokenFromJson(json);
}
