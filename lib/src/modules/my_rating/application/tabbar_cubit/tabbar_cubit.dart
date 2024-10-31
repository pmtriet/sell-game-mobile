import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tabbar_state.dart';
part 'tabbar_cubit.freezed.dart';

class TabbarCubit extends Cubit<TabbarState> {
  TabbarCubit() : super(const TabbarState.initial(false, 1));

  void onLoadingData() {
    emit(state.copyWith(isLoading: true));
  }

  void unLoadingData() {
    emit(state.copyWith(isLoading: false));
  }

  void onTapToNotRatingYetTab() {
    if (state.index != 1) {
      emit(const _Initial(false, 1,));
    }
  }

  void onTapToRatedTab() {
    if (state.index != 2) {
      emit(const _Initial(false, 2,));
    }
  }

  void onTapToBuyerRatingTab() {
    if (state.index != 3) {
      emit(const _Initial(false, 3,));
    }
  }
}
