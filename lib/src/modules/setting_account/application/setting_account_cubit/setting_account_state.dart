part of 'setting_account_cubit.dart';

@freezed
class SettingAccountState with _$SettingAccountState {
  const factory SettingAccountState.initial() = _Initial;
  const factory SettingAccountState.loading() = _Loading;
  const factory SettingAccountState.error(String errorMessage) = _Error;
  const factory SettingAccountState.success(String successMessage) = _Success;

}
