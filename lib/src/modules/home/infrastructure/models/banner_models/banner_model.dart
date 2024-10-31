import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/banner.dart';
import 'banner_image_model.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
class BannerModel with _$BannerModel implements AppBanner {
  const BannerModel._();

  const factory BannerModel({
    @Default(0) int id,
    @Default(BannerImageModel()) BannerImageModel image,
  }) = _BannerModel;

  factory BannerModel.fromJson(dynamic json) => _$BannerModelFromJson(json);
}
