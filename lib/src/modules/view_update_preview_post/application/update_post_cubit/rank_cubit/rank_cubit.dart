import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/mixin/cancelable_base_bloc.dart';

part 'rank_state.dart';
part 'rank_cubit.freezed.dart';

class RankCubit extends Cubit<RankState> with CancelableBaseBloc<RankState>{
  String selected;
  RankCubit(this.selected) : super(const RankState.initial(false, null, '')){
    current = selected;
  }

  List<String> ranks = [];

  String? current;
  bool isInitial = true;

  void init(List<String> newList) {
    emit(_Initial(true, ranks, selected));

    ranks = newList;

    if (isInitial) {
      isInitial = !isInitial;
    } else {
      selected = '';
    }

    emit(_Initial(false, ranks, selected));
  }

  void onSelect(String value) {
    current = value;
  }

  String? getRank() {
    return current;
  }
}
