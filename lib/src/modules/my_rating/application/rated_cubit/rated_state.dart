part of 'rated_cubit.dart';

@freezed
class RatedState with _$RatedState {
  const factory RatedState.initial(bool isLoading, List<RatedModel>? products) = _Initial;
}
