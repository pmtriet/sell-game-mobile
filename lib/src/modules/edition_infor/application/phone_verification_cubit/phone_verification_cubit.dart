import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/validator.dart';

part 'phone_verification_state.dart';
part 'phone_verification_cubit.freezed.dart';

class PhoneVerificationCubit extends Cubit<PhoneVerificationState>
    with CancelableBaseBloc<PhoneVerificationState> {
  PhoneVerificationCubit() : super(const PhoneVerificationState.initial());

  void validate(String otp) {
    emit(const _Loading());
    if (Validator.isEmptyOtp(otp)) {
      emit(_Error(S.current.error_empty_otp));
    } else if (!Validator.isValidOtp(otp)) {
      emit(_Error(S.current.error_invalid_otp));
    } else {
      emit(const _Success());
    }
  }

  Future<void> resendOtp() async {
    emit(const _Loading());
    //TODO: call api resend otp
    await Future.delayed(const Duration(seconds: 3));
    //if call api success
    emit(const _Resend());
    //if call api error
    // emit(_Error(S.current.error_unexpected));
  }
}
