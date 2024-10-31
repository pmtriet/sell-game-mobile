import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import 'marketplace_category_model.dart';

part 'marketplace_product_model.freezed.dart';
part 'marketplace_product_model.g.dart';

@freezed
class MarketplaceProductModel with _$MarketplaceProductModel {
  const MarketplaceProductModel._();

  const factory MarketplaceProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String code,
    @Default(MarketplaceCategoryModel()) MarketplaceCategoryModel category,
    @Default([]) List<ProductImageModel> images,
    @Default(0) int price,
    @Default(0.0) double saleOff,
    @Default('') String updatedAt, 
  }) = _MarketplaceProductModel;

  factory MarketplaceProductModel.fromJson(dynamic json) =>
      _$MarketplaceProductModelFromJson(json);
}
