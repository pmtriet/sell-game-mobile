part of 'post_sold_cubit.dart';

@freezed
class PostSoldState with _$PostSoldState {
  const factory PostSoldState.initial(bool isLoading, List<MarketplaceProductModel>? products) = _Initial;
}
