import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_error.freezed.dart';

@freezed
class RegisterError with _$RegisterError {
  const factory RegisterError.invalidName() = _InvalidName;
  const factory RegisterError.emptyName() = _EmptyName;
  const factory RegisterError.invalidEmail() = _InvalidEmail;
  const factory RegisterError.emptyEmail() = _EmptyEmail;
  const factory RegisterError.invalidPasswordLength() = _InvalidPasswordLength;
  const factory RegisterError.invalidPassword() = _InvalidPassword;
  const factory RegisterError.other(String message) = _Other;
}
