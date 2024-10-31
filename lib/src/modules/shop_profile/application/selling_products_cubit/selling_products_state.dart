part of 'selling_products_cubit.dart';

@freezed
class SellingProductsState with _$SellingProductsState {
  const factory SellingProductsState.initial(bool isLoading, List<MarketplaceProductModel>? products,) = _Initial;
}
