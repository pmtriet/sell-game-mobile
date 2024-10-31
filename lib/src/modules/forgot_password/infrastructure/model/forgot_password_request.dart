import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_request.freezed.dart';
part 'forgot_password_request.g.dart';

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const ForgotPasswordRequest._();

  const factory ForgotPasswordRequest({
    @Default('') String email,
  }) = _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}