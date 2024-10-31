import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/constants/app_constants.dart';
import '../../../../../common/mixin/cancelable_base_bloc.dart';

part 'ranks_filter_state.dart';
part 'ranks_filter_cubit.freezed.dart';

@lazySingleton
class RanksFilterCubit extends Cubit<RanksFilterState>
    with CancelableBaseBloc<RanksFilterState> {
  RanksFilterCubit(this.ranks)
      : super(const RanksFilterState.initial(true, null, null, null)) {
    _init();
  }

  final List<String> ranks;
  late List<String> showRanks;
  bool? viewMore;
  List<String>? selectedRanks;

  void _init() {
    if (ranks.length > AppConstants.maxRankDisplayInFilter) {
      showRanks =
          List.of(ranks.sublist(0, AppConstants.maxRankDisplayInFilter));
      viewMore = true;
      emit(_Initial(false, showRanks, viewMore, null));
    } else {
      showRanks = List.of(ranks);
      emit(_Initial(false, showRanks, null, null));
    }
  }

  void viewmore() {
    emit(state.copyWith(isLoading: true));
    showRanks = List.of(ranks);
    viewMore = false;
    emit(_Initial(false, showRanks, viewMore, selectedRanks));
  }

  void shortcut() {
    emit(state.copyWith(isLoading: true));
    showRanks = List.of(ranks.sublist(0, AppConstants.maxRankDisplayInFilter));
    viewMore = true;
    emit(_Initial(false, showRanks, viewMore, selectedRanks));
  }

  void onTapRank(String rank) {
    emit(state.copyWith(isLoading: true));
    if (selectedRanks != null) {
      if (selectedRanks!.any((selectedRank) => selectedRank == rank)) {
        selectedRanks!.remove(rank);
        emit(_Initial(false, showRanks, viewMore, selectedRanks));
      } else {
        selectedRanks!.add(rank);
        emit(_Initial(false, showRanks, viewMore, selectedRanks));
      }
    } else {
      selectedRanks = [rank];
      emit(_Initial(false, showRanks, viewMore, selectedRanks));
    }
  }

  void onClearSelectedRanks() {
    emit(state.copyWith(isLoading: true));
    selectedRanks = null;
    emit(_Initial(false, showRanks, viewMore, selectedRanks));
  }
}
