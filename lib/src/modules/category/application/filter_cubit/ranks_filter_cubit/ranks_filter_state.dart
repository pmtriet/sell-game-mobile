part of 'ranks_filter_cubit.dart';

@freezed
class RanksFilterState with _$RanksFilterState {
  const factory RanksFilterState.initial(bool isLoading, List<String>? ranks, bool? more, List<String>? selectedRanks) = _Initial;
}
