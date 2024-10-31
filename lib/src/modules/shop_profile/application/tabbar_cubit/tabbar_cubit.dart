import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'tabbar_state.dart';
part 'tabbar_cubit.freezed.dart';

class TabbarCubit extends Cubit<TabbarState> with CancelableBaseBloc<TabbarState>{
  TabbarCubit() : super(const TabbarState.initial(1));

  Future<void> onTapToSellingTab() async {
    if (state.index != 1) {
      emit(const _Initial(1));
    }
  }

  Future<void> onTapToSoldTab() async {
    if (state.index != 2) {
      emit(const _Initial(2));
    }
  }
}
