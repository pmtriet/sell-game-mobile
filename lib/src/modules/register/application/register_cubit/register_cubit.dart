import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/validator.dart';
import '../../domain/interface/register_repository_interface.dart';
import '../../domain/request_models/register_request.dart';
import '../error/register_error.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState>
    with CancelableBaseBloc<RegisterState> {
  final IRegisterRepository _repository;

  RegisterCubit(this._repository) : super(const RegisterState.initial());

  Future<void> register(RegisterRequest request) async {
    if (Validator.isEmptyUserName(request.fullname)) {
      emit(const _Error(RegisterError.emptyName()));
    } else if (!Validator.isValidFullName(request.fullname)) {
      emit(const _Error(RegisterError.invalidName()));
    } else if (Validator.isEmptyEmail(request.email)) {
      emit(const _Error(RegisterError.emptyEmail()));
    } else if (!Validator.isValidEmail(request.email)) {
      emit(const _Error(RegisterError.invalidEmail()));
    } else if (!Validator.isValidPasswordLength(request.password)) {
      emit(const _Error(RegisterError.invalidPasswordLength()));
    } else if (!Validator.isValidPassword(request.password)) {
      emit(const _Error(RegisterError.invalidPassword()));
    } else {
      emit(const _Loading());
      final result = await _repository.register(request);
      emit(result.fold(
        (success) => const _Success(),
        (failure) => _Error(
          RegisterError.other(failure.message),
        ),
      ));
    }
  }

  void emitToInitialState() {
    if (state is _Error) {
      emit(const _Initial());
    }
  }
}
