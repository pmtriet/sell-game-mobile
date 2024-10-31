import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/category.dart';

part 'category_thumbnail_model.freezed.dart';
part 'category_thumbnail_model.g.dart';

@freezed
class CategoryThumbnailModel with _$CategoryThumbnailModel implements CategoryThumbnail {
  const CategoryThumbnailModel._();

  const factory CategoryThumbnailModel({
    @Default('') String filePath,
  }) = _CategoryThumbnailModel;

  factory CategoryThumbnailModel.fromJson(dynamic json) => _$CategoryThumbnailModelFromJson(json);
}
