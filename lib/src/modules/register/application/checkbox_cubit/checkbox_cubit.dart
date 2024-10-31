import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'checkbox_state.dart';
part 'checkbox_cubit.freezed.dart';

class CheckboxCubit extends Cubit<CheckboxState> with CancelableBaseBloc<CheckboxState>{
  CheckboxCubit() : super(const CheckboxState.unchecked());

  void onCheck(bool value) {
    if (value) {
      emit(const _Checked());
    } else {
      emit(const _Unchecked());
    }
  }
}
