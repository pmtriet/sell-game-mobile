import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/validator.dart';
import '../../domain/interface/setting_account_repository_interface.dart';
import '../../domain/request_models/change_password_request.dart';

part 'setting_account_state.dart';
part 'setting_account_cubit.freezed.dart';

class SettingAccountCubit extends Cubit<SettingAccountState>
    with CancelableBaseBloc<SettingAccountState> {
  final ISettingAccountRepository _repository;
  SettingAccountCubit(this._repository)
      : super(const SettingAccountState.initial());

  void changePassword(
      String currentPassword, String newPassword, String newPasswordAgain) {
    emit(const _Loading());
    if (Validator.isEmptyPassword(currentPassword)) {
      emit(_Error(S.current.empty_current_password));
    } else if (Validator.isEmptyPassword(newPassword)) {
      emit(_Error(S.current.empty_new_password));
    } else if (Validator.isEmptyPassword(newPasswordAgain)) {
      emit(_Error(S.current.empty_new_password_again));
    } else if (!Validator.isValidPasswordLength(currentPassword) ||
        !Validator.isValidPasswordLength(newPassword) ||
        !Validator.isValidPasswordLength(newPasswordAgain)) {
      emit(_Error(S.current.error_invalid_password_length));
    } else if (!Validator.isValidPassword(currentPassword) ||
        !Validator.isValidPassword(newPassword) ||
        !Validator.isValidPassword(newPasswordAgain)) {
      emit(_Error(S.current.error_invalid_password));
    } else if (newPassword != newPasswordAgain) {
      emit(_Error(S.current.error_new_password_again));
    } else {
      final request = ChangePasswordRequest(
          oldPassword: currentPassword, newPassword: newPassword);
      _changePassword(request);
    }
  }

  Future<void> _changePassword(ChangePasswordRequest request) async {
    emit(const _Loading());

    final result = await _repository.changePassword(request);
    emit(result.fold(
      (success) => _Success(success.message),
      (failure) => _Error(failure.message),
    ));
  }
}
