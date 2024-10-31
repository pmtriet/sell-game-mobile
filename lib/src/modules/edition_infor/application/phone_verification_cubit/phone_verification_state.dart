part of 'phone_verification_cubit.dart';

@freezed
class PhoneVerificationState with _$PhoneVerificationState {
  const factory PhoneVerificationState.initial() = _Initial;
  const factory PhoneVerificationState.error(String message) = _Error;
  const factory PhoneVerificationState.loading() = _Loading;
  const factory PhoneVerificationState.resend() = _Resend;
  const factory PhoneVerificationState.success() = _Success;
}
