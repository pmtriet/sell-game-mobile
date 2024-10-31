part of 'ranks_cubit.dart';

@freezed
class RanksState with _$RanksState {
  const factory RanksState.initial(bool isLoading, List<String>? ranks) = _Initial;
}
