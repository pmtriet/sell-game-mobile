part of 'product_selling_cubit.dart';

@freezed
class ProductSellingState with _$ProductSellingState {
  const factory ProductSellingState.initial(bool isLoading, List<MarketplaceProductModel> products) = _Initial;
}
