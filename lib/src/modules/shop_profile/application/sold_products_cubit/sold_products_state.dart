part of 'sold_products_cubit.dart';

@freezed
class SoldProductsState with _$SoldProductsState {
  const factory SoldProductsState.initial(bool isLoading, List<MarketplaceProductModel>? products) = _Initial;
}
