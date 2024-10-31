import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/category.dart';
import 'category_attribute_model.dart';
import 'category_signinmethod_model.dart';
import 'category_thumbnail_model.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel implements Category {
  const CategoryModel._();

  const factory CategoryModel({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String slug,
    @Default([]) List<CategoryAttributeModel> attributes,
    @Default([]) List<String> ranks,
    @Default([]) List<CategorySigninMethodModel> signInMethods,
    @Default(CategoryThumbnailModel()) CategoryThumbnailModel thumbnail,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(dynamic json) => _$CategoryModelFromJson(json);
}
