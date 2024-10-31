import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../marketplace/infrastructure/models/marketplace_category_model.dart';
import '../category_product_models/product_image_model.dart';

part 'suggesting_product_model.freezed.dart';
part 'suggesting_product_model.g.dart';

@freezed
class SuggestingProductModel with _$SuggestingProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory SuggestingProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String code,
    @Default(MarketplaceCategoryModel()) MarketplaceCategoryModel category,
    @Default([]) List<ProductImageModel> images,
    @Default(0) int price,
    @Default(0) double saleOff,
    @Default(0) int currentPrice,
    @Default('') String updatedAt,
  }) = _SuggestingProductModel;

  // fromJson and toJson methods
  factory SuggestingProductModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestingProductModelFromJson(json);
}