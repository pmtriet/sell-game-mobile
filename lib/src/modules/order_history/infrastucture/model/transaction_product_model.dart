import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../buy/infrastructor/models/category_product.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../home/infrastructure/models/category_product_models/product_signinmethod_model.dart';
import '../../../marketplace/infrastructure/models/marketplace_category_model.dart';
import '../../../view_update_preview_post/infrastructure/models/account_product_model.dart';

part 'transaction_product_model.freezed.dart';
part 'transaction_product_model.g.dart';

@freezed
class TransactionProductModel with _$TransactionProductModel {
  const factory TransactionProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String code,
    @Default(0) int price,
    @Default(0) int currentPrice,
    @Default(0) double saleOff,
    @Default([]) List<ProductImageModel> images,
    @Default([]) List<ProductAttribute> attributes,
    @Default('') String rank,
    @Default(MarketplaceCategoryModel()) MarketplaceCategoryModel category,
    @Default(ProductSigninmethodModel()) ProductSigninmethodModel signInMethod,
    @Default('') String productType,
    @Default(AccountProductModel()) AccountProductModel productInfo,
  }) = _TransactionProductModel;

  factory TransactionProductModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionProductModelFromJson(json);
}