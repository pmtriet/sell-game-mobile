import 'package:freezed_annotation/freezed_annotation.dart';

part 'marketplace_shop_model.freezed.dart';
part 'marketplace_shop_model.g.dart';

@freezed
class MarketpaceShopModel with _$MarketpaceShopModel{
  const MarketpaceShopModel._();

  const factory MarketpaceShopModel({
    @Default(0) int id,
    @Default('') String name,
  }) = _MarketpaceShopModel;

  factory MarketpaceShopModel.fromJson(dynamic json) => _$MarketpaceShopModelFromJson(json);
}
