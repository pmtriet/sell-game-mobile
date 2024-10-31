import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/mixin/cancelable_base_bloc.dart';

part 'filter_price_state.dart';
part 'filter_price_cubit.freezed.dart';

class FilterPriceCubit extends Cubit<FilterPriceState> with CancelableBaseBloc<FilterPriceState>{
  FilterPriceCubit() : super(const FilterPriceState.lowToHigh());
  void filterPriceLowToHigh() {
    emit(const FilterPriceState.lowToHigh());
  }

  void filterPriceHighToLow() {
    emit(const FilterPriceState.highToLow());
  }
}
