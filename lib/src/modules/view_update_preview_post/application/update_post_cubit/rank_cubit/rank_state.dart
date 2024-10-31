part of 'rank_cubit.dart';

@freezed
class RankState with _$RankState {
  const factory RankState.initial(bool isLoading, List<String>? ranks, String selected) = _Initial;
}
