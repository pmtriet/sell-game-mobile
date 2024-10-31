part of 'rating_cubit.dart';

@freezed
class RatingState with _$RatingState {
  const factory RatingState.initial(bool isLoading, String? error, bool? isSuccess) = _Initial;
}
