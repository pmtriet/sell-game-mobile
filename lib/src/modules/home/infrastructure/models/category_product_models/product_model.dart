import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product.dart';
import '../category_models/category_model.dart';
import 'product_attribute_model.dart';
import 'product_image_model.dart';
import 'product_signinmethod_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class CategoryProductModel with _$CategoryProductModel implements CategoryProduct {
  const CategoryProductModel._();

  const factory CategoryProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String code,
    @Default(0) int price,
    @Default(0) int currentPrice,
    @Default(0.0) double saleOff,
    @Default('') String rank,
    @Default(ProductSigninmethodModel()) ProductSigninmethodModel signInMethod,
    @Default([]) List<ProductImageModel> images,
    @Default([]) List<ProductAttributeModel> attributes,
    @Default('') String createdAt,
    @Default(CategoryModel()) CategoryModel category,
  }) = _CategoryProductModel;

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductModelFromJson(json);
}
