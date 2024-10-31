part of 'filter_option_cubit.dart';

@freezed
class FilterOptionState with _$FilterOptionState {
  const factory FilterOptionState.newestOptionFilter() = _NewestOptionFilter;
  const factory FilterOptionState.saleOptionFilter() = _SaleOptionFilter;
}
