part of 'marketplace_cubit.dart';

@freezed
class MarketplaceState with _$MarketplaceState {
  const factory MarketplaceState.initial(bool isLoading, List<MarketplaceProductFollowShopModel>? productFollowShop, bool? displayLoading) = _Initial;
}
