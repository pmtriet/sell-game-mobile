part of 'buyer_rating_cubit.dart';

@freezed
class BuyerRatingState with _$BuyerRatingState {
  const factory BuyerRatingState.initial(bool isLoading, List<BuyerRatingModel>? products) = _Initial;
}
