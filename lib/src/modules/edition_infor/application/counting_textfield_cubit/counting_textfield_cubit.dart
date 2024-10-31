import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/constants/app_constants.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'counting_textfield_state.dart';
part 'counting_textfield_cubit.freezed.dart';

class CountingTextfieldCubit extends Cubit<CountingTextfieldState> with CancelableBaseBloc<CountingTextfieldState>{
  CountingTextfieldCubit() : super(const CountingTextfieldState.initial()) {
    countdown();
  }

  Timer? _timer;
  int currentCount = AppConstants.countdownTimer;

  void countdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentCount > 0) {
        emit(CountingTextfieldState.counting(currentCount));
        currentCount--;
      } else {
        timer.cancel();
        emit(const CountingTextfieldState.resend());
      }
    });
  }

  void stopCountdown() {
    _timer?.cancel();
    emit(const CountingTextfieldState.initial());
  }
}