import 'package:freezed_annotation/freezed_annotation.dart';

import '../category_product_models/product_model.dart';
import 'category_model.dart';

part 'category_and_products_model.freezed.dart';
part 'category_and_products_model.g.dart';

@freezed
class CategoryAndProductsModel with _$CategoryAndProductsModel {
  const CategoryAndProductsModel._();

  const factory CategoryAndProductsModel({
    @Default(CategoryModel()) CategoryModel category,
    @Default([]) List<CategoryProductModel> products,
  }) = _CategoryAndProductsModel;

  factory CategoryAndProductsModel.fromJson(dynamic json) => _$CategoryAndProductsModelFromJson(json);
}