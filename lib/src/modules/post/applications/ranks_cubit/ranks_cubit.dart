import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'ranks_state.dart';
part 'ranks_cubit.freezed.dart';

class RanksCubit extends Cubit<RanksState> with CancelableBaseBloc<RanksState> {
  RanksCubit() : super(const RanksState.initial(false, null));

  List<String> ranks = [];

  String? selected;

  void init(List<String> newList) {
    emit(_Initial(true, ranks));
    selected = null;

    ranks = newList;

    emit(_Initial(false, ranks));
  }

  void onSelect(String value) {
    selected = value;
  }

  String? getRank() {
    return selected;
  }
}
