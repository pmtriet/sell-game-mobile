import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../domain/forgot_password_repository_interface.dart';
import '../../infrastructure/model/forgot_password_request.dart';

part 'resend_email_state.dart';
part 'resend_email_cubit.freezed.dart';

class ResendEmailCubit extends Cubit<ResendEmailState> with CancelableBaseBloc<ResendEmailState> {
  final IForgotPasswordRepository _repository;
  ResendEmailCubit(this._repository) : super(const ResendEmailState.initial());

  Future<void> resendEmail(String email) async {
    var request = ForgotPasswordRequest(email: email);
    var response = await _repository.forgorPassword(request);

    response.fold((success) {
      emit(const _Initial());
    }, (error) {
      emit(_Error(error.message));
    });
  }
}
