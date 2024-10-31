import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/product.dart';

part 'product_image_model.freezed.dart';
part 'product_image_model.g.dart';

@freezed
class ProductImageModel with _$ProductImageModel implements ProductImage {
  const ProductImageModel._();

  const factory ProductImageModel({
    @Default('') String fileName,
    @Default('') String filePath,
  }) = _ProductImageModel;

  factory ProductImageModel.fromJson(dynamic json) => _$ProductImageModelFromJson(json);
}