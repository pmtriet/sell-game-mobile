import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_status_post.dart';
import '../../domain/interface/management_post_repository_interface.dart';
import '../../infrastructure/models/post_status_model.dart';

part 'tabbar_state.dart';
part 'tabbar_cubit.freezed.dart';

class TabbarCubit extends Cubit<TabbarState>
    with CancelableBaseBloc<TabbarState> {
  final IManagementPostRepository _repository;
  final int? indexNavigating;
  TabbarCubit(this._repository, this.indexNavigating)
      : super(indexNavigating == null
            ? const TabbarState.initial(true, 1, 0, 0, 0, 0, 0)
            : emitToNavigatingIndex(indexNavigating)) {
    getManagementPost();
  }

  int sellingCount = 0;
  int pendingCount = 0;
  int rejectedCount = 0;
  int soldCount = 0;
  int deletedCount = 0;

  static TabbarState emitToNavigatingIndex(int index) {
    switch (index) {
      case 2:
        return const TabbarState.initial(true, 2, 0, 0, 0, 0, 0);
      case 3:
        return const TabbarState.initial(true, 3, 0, 0, 0, 0, 0);
      case 4:
        return const TabbarState.initial(true, 4, 0, 0, 0, 0, 0);
      default:
        return const TabbarState.initial(true, 1, 0, 0, 0, 0, 0);
    }
  }

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
        case PostStatus.pending:
          pendingCount = item.count;
          break;
        case PostStatus.rejected:
          rejectedCount = item.count;
          break;
        case PostStatus.sold:
          soldCount = item.count;
          break;
        case PostStatus.deleted:
          deletedCount = item.count;
          break;
      }
    }
    emit(state.copyWith(
        isLoading: false,
        sellingCount: sellingCount,
        pedingCount: pendingCount,
        rejectedCount: rejectedCount,
        soldCount: soldCount));
  }

  void onTapToSellingTab() {
    if (state.index != 1) {
      emit(_Initial(false, 1, sellingCount, pendingCount, rejectedCount,
          soldCount, deletedCount));
    }
  }

  void onTapToPendingTab() {
    if (state.index != 2) {
      emit(_Initial(false, 2, sellingCount, pendingCount, rejectedCount,
          soldCount, deletedCount));
    }
  }

  void onTapToRejectTab() {
    if (state.index != 3) {
      emit(_Initial(false, 3, sellingCount, pendingCount, rejectedCount,
          soldCount, deletedCount));
    }
  }

  void onTapToDeleteTab() {
    if (state.index != 5) {
      emit(_Initial(false, 5, sellingCount, pendingCount, rejectedCount,
          soldCount, deletedCount));
    }
  }

  void onTapToSoldTab() {
    if (state.index != 4) {
      emit(_Initial(false, 4, sellingCount, pendingCount, rejectedCount,
          soldCount, deletedCount));
    }
  }
}
