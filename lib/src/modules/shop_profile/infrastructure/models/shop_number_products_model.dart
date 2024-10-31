import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_number_products_model.freezed.dart';
part 'shop_number_products_model.g.dart';

@freezed
class ShopNumberProductsModel with _$ShopNumberProductsModel {
  const ShopNumberProductsModel._();

  const factory ShopNumberProductsModel({
    @Default(0) int products,
    @Default(0) int transactions,
  }) = _ShopNumberProductsModel;

  factory ShopNumberProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ShopNumberProductsModelFromJson(json);
}
