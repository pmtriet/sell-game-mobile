import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'display_change_password_state.dart';
part 'display_change_password_cubit.freezed.dart';

class DisplayChangePasswordCubit extends Cubit<DisplayChangePasswordState> with CancelableBaseBloc<DisplayChangePasswordState>{
  DisplayChangePasswordCubit() : super(const DisplayChangePasswordState.initial(false));

  void changeState(){
    bool isDisplayed = state.isDisplayed;
    emit(state.copyWith(isDisplayed: !isDisplayed));
  }
}
