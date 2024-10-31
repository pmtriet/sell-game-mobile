import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/validator.dart';
import '../../domain/forgot_password_repository_interface.dart';
import '../../infrastructure/model/forgot_password_request.dart';

part 'account_verification_state.dart';
part 'account_verification_cubit.freezed.dart';

class AccountVerificationCubit extends Cubit<AccountVerificationState>
    with CancelableBaseBloc<AccountVerificationState> {
  final IForgotPasswordRepository _repository;
  AccountVerificationCubit(this._repository)
      : super(const AccountVerificationState.initial(false, null, null, null));

  Future<void> forgetPassword(String email) async {
    emit(const _Initial(true, null, null, null));

    if (Validator.isEmptyEmail(email.trim())) {
      emit(_Initial(false, S.current.empty_email, null, null));
    } else if (!Validator.isValidEmail(email.trim())) {
      emit(_Initial(false, S.current.error_invalid_email, null, null));
    } else {
      var request = ForgotPasswordRequest(email: email.trim());
      var response = await _repository.forgorPassword(request);

      response.fold((success) {
        emit(const _Initial(false, null, null, true));
      }, (error) {
        emit(_Initial(false, null, error.message, null));
      });
    }
  }
}
