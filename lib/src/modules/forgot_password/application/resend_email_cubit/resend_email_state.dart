part of 'resend_email_cubit.dart';

@freezed
class ResendEmailState with _$ResendEmailState {
  const factory ResendEmailState.initial() = _Initial;
  const factory ResendEmailState.error(String error) = _Error;
}
