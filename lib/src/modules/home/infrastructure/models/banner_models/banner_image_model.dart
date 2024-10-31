import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/banner.dart';

part 'banner_image_model.freezed.dart';
part 'banner_image_model.g.dart';

@freezed
class BannerImageModel with _$BannerImageModel implements BannerImage {
  const BannerImageModel._();

  const factory BannerImageModel({
    @Default('') String filePath,
  }) = _BannerImageModel;

  factory BannerImageModel.fromJson(Map<String, dynamic> json) =>
      _$BannerImageModelFromJson(json);
}
