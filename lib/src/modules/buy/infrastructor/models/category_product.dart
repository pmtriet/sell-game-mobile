import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shop_profile/infrastructure/models/shop_account_model.dart';

part 'category_product.freezed.dart';
part 'category_product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory ProductModel({
    required int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String code,
    @Default(0) int price,
    @Default(0) int currentPrice,
    @Default(0) int finalPrice,
    @Default(0) double priceReduced,
    @Default(0) double saleOff,
    @Default('') String rank,
    @Default(ProductSignInMethod()) ProductSignInMethod signInMethod,
    @Default([]) List<ProductImage> images,
    @Default([]) List<ProductAttribute> attributes,
    @Default('') String createdAt,
    @Default(ProductCategory()) ProductCategory category,
    @Default('') String productType,
    @Default(ShopAccountModel()) ShopAccountModel account,
  }) = _ProductModel;

  // fromJson and toJson methods
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
class ProductSignInMethod with _$ProductSignInMethod {
  @JsonSerializable()
  const factory ProductSignInMethod({
    @Default(0) int id,
    @Default('') String title,
  }) = _ProductSignInMethod;

  factory ProductSignInMethod.fromJson(Map<String, dynamic> json) =>
      _$ProductSignInMethodFromJson(json);
}

@freezed
class ProductAttribute with _$ProductAttribute {
  @JsonSerializable()
  const factory ProductAttribute({
    @Default('') String key,
    @Default('') String title,
    @Default('') String value,
  }) = _ProductAttribute;

  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeFromJson(json);
}

@freezed
class ProductImage with _$ProductImage {
  @JsonSerializable()
  const factory ProductImage({
    @Default('') String fileName,
    @Default('') String filePath,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
}

@freezed
class ProductCategory with _$ProductCategory {
  @JsonSerializable()
  const factory ProductCategory({
    @Default(0) int id,
    @Default('') String name,
  }) = _ProductCategory;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);
}
