import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product.dart';

part 'product_attribute_model.freezed.dart';
part 'product_attribute_model.g.dart';

@freezed
class ProductAttributeModel with _$ProductAttributeModel implements ProductAttribute {
  const ProductAttributeModel._();

  const factory ProductAttributeModel({
    @Default('') String key,
    @Default('') String title,
    @Default('') String value,
  }) = _ProductAttributeModel;

  factory ProductAttributeModel.fromJson(dynamic json) =>
      _$ProductAttributeModelFromJson(json);
}
