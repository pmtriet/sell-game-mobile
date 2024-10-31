part of 'filter_price_cubit.dart';

@freezed
class FilterPriceState with _$FilterPriceState {
  const factory FilterPriceState.lowToHigh() = _LowToHigh;
  const factory FilterPriceState.highToLow() = _HighToLow;
}
