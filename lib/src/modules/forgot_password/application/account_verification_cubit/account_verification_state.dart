part of 'account_verification_cubit.dart';

@freezed
class AccountVerificationState with _$AccountVerificationState {
  const factory AccountVerificationState.initial(bool isLoading, String? errorEmail, String? error, bool? success) = _Initial;
}
