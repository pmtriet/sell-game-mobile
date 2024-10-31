import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../transaction_history/infrastructure/models/order_model.dart';

part 'my_rating_product_model.freezed.dart';
part 'my_rating_product_model.g.dart';

@freezed
class MyRatingProductModel with _$MyRatingProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory MyRatingProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String code,
    @Default([]) List<ProductImageModel> images,
    @Default(AccountModel()) AccountModel account,
    @Default(CategoryModel()) CategoryModel category,
  }) = _MyRatingProductModel;

  factory MyRatingProductModel.fromJson(Map<String, dynamic> json) =>
      _$MyRatingProductModelFromJson(json);
}