import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  @JsonSerializable(explicitToJson: true)
  const factory OrderModel({
    @Default(0) int id,
    @Default(0) int value,
    @Default(OrderProductModel()) OrderProductModel product,
    @Default('') String createdAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderProductModel with _$OrderProductModel {
  const factory OrderProductModel({
    @Default(0) int id,
    @Default('') String code,
    @Default('') String title,
    @Default(AccountModel()) AccountModel account,
    @Default([]) List<ProductImageModel> images,
    @Default(CategoryModel()) CategoryModel category,
    @Default(RatingNumberModel()) RatingNumberModel? rating,
    @Default('') String productType,
  }) = _OrderProductModel;

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);
}

@freezed
class AccountModel with _$AccountModel {
  @JsonSerializable(explicitToJson: true)
  const factory AccountModel({
    @Default(0) int id,
    @Default('') String fullname,
    @Default(AvatarModel()) AvatarModel avatar,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}

@freezed
class AvatarModel with _$AvatarModel {
  @JsonSerializable(explicitToJson: true)
  const factory AvatarModel({
    @Default('') String filePath,
    @Default('') String fileName,
  }) = _AvatarModel;

  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);
}


@freezed
class CategoryModel with _$CategoryModel {
  @JsonSerializable(explicitToJson: true)
  const factory CategoryModel({
    @Default(0) int id,
    @Default('') String name,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
class RatingNumberModel with _$RatingNumberModel {
  const factory RatingNumberModel({
    @Default(0) int star,
  }) = _RatingNumberModel;

  factory RatingNumberModel.fromJson(Map<String, dynamic> json) =>
      _$RatingNumberModelFromJson(json);
}
