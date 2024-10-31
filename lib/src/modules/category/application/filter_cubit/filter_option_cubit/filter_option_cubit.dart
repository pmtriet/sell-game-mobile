import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/mixin/cancelable_base_bloc.dart';

part 'filter_option_state.dart';
part 'filter_option_cubit.freezed.dart';

class FilterOptionCubit extends Cubit<FilterOptionState> with CancelableBaseBloc<FilterOptionState>{
  FilterOptionCubit() : super(const FilterOptionState.newestOptionFilter());

  void tapOnNewestOption() =>
      emit(const FilterOptionState.newestOptionFilter());
  void tapOnSaleOption() {
    emit(const FilterOptionState.saleOptionFilter());
  }
}
