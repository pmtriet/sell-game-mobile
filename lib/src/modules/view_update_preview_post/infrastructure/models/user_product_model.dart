import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/infrastructure/models/category_product_models/product_attribute_model.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../home/infrastructure/models/category_product_models/product_signinmethod_model.dart';
import '../../../marketplace/infrastructure/models/marketplace_category_model.dart';
import 'account_product_model.dart';

part 'user_product_model.freezed.dart';
part 'user_product_model.g.dart';

@freezed
class UserProductModel with _$UserProductModel {
  const factory UserProductModel({
    required int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String code,
    @Default(0) int price,
    @Default(0) double saleOff,
    @Default('') String rank,
    @Default(ProductSigninmethodModel()) ProductSigninmethodModel signInMethod,
    @Default([]) List<ProductImageModel> images,
    @Default([]) List<ProductAttributeModel> attributes,
    @Default('') String updatedAt, 
    @Default(MarketplaceCategoryModel()) MarketplaceCategoryModel category,
    @Default('') String productType,
    @Default(AccountProductModel()) AccountProductModel productInfo,
  }) = _UserProductModel;

  factory UserProductModel.fromJson(Map<String, dynamic> json) =>
      _$UserProductModelFromJson(json);
}