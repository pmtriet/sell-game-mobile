import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'counter_state.dart';
part 'counter_cubit.freezed.dart';

class CounterCubit extends Cubit<CounterState>
    with CancelableBaseBloc<CounterState> {
  CounterCubit() : super(const CounterState.initial());

  Timer? _timer;
  int currentCount = AppConstants.countdownTimer;

  void stopCounting() {
    _timer?.cancel();
    emit(const _Initial());
  }

  void onCount() {
    currentCount = AppConstants.countdownTimer;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentCount > 0) {
        emit(_Count(currentCount));
        currentCount--;
      } else {
        timer.cancel();
        emit(const _Initial());
      }
    });
  }
}
