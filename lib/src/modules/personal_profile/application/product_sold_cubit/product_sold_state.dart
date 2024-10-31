part of 'product_sold_cubit.dart';

@freezed
class ProductSoldState with _$ProductSoldState {
  const factory ProductSoldState.initial(bool isLoading, List<MarketplaceProductModel> products) = _Initial;
}
