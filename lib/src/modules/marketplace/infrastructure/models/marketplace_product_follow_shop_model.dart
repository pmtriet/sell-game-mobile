import 'package:freezed_annotation/freezed_annotation.dart';

import 'marketplace_product_model.dart';
import 'marketplace_shop_model.dart';

part 'marketplace_product_follow_shop_model.freezed.dart';
part 'marketplace_product_follow_shop_model.g.dart';

@freezed
class MarketplaceProductFollowShopModel with _$MarketplaceProductFollowShopModel {
  const MarketplaceProductFollowShopModel._();

  const factory MarketplaceProductFollowShopModel({
    @Default(MarketpaceShopModel()) MarketpaceShopModel account,
    @Default([]) List<MarketplaceProductModel> data,
  }) = _MarketplaceProductFollowShopModel;

  factory MarketplaceProductFollowShopModel.fromJson(dynamic json) =>
      _$MarketplaceProductFollowShopModelFromJson(json);
}
