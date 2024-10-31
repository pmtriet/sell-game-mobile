import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../marketplace/infrastructure/models/marketplace_category_model.dart';

part 'saved_post_model.freezed.dart';
part 'saved_post_model.g.dart';

@freezed
class SavedPostModel with _$SavedPostModel {
  const SavedPostModel._();

  const factory SavedPostModel({
    @Default(0) int id,
    @Default('') String title,
    @Default(MarketplaceCategoryModel()) MarketplaceCategoryModel category,
    @Default([]) List<ProductImageModel> images,
    @Default(0) int currentPrice,
  }) = _SavedPostModel;

  factory SavedPostModel.fromJson(dynamic json) =>
      _$SavedPostModelFromJson(json);
}