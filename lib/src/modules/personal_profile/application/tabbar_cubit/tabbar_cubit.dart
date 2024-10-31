import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_status_post.dart';
import '../../../management_post/infrastructure/models/post_status_model.dart';
import '../../domain/interface/personal_profile_repository_interface.dart';

part 'tabbar_state.dart';
part 'tabbar_cubit.freezed.dart';

class TabbarCubit extends Cubit<TabbarState> with CancelableBaseBloc<TabbarState>{
  final IPersonalProfileRepository _repository;
  TabbarCubit(this._repository)
      : super(const TabbarState.initial(true, 1, 0, 0)) {
    getManagementPost();
  }

  int sellingCount = 0;
  int soldCount = 0;

  Future<void> getManagementPost() async {
    final result = await _repository.getManagementPost();
    result.fold((success) => updateSellingCount(success),
        (failure) => emit(state.copyWith(isLoading: false)));
  }

  void updateSellingCount(List<PostStatusModel> list) {
    if (list.isEmpty) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    for (var item in list) {
      PostStatus status = returnPostStatus(item.status);
      switch (status) {
        case PostStatus.selling:
          sellingCount = item.count;
          break;
        case PostStatus.sold:
          soldCount = item.count;
          break;
        default: 
          break;
      }
    }
    emit(state.copyWith(
        isLoading: false, sellingCount: sellingCount, soldCount: soldCount));
  }

  void onTapToSellingTab() {
    if (state.index != 1) {
      emit(_Initial(false, 1, sellingCount, soldCount));
    }
  }

  void onTapToSoldTab() {
    if (state.index != 2) {
      emit(_Initial(false, 2, sellingCount, soldCount));
    }
  }
  void refresh(){
    emit(state.copyWith(isLoading: true));
    getManagementPost();
  }
}
