import 'package:freezed_annotation/freezed_annotation.dart';

part 'marketplace_category_model.freezed.dart';
part 'marketplace_category_model.g.dart';

@freezed
class MarketplaceCategoryModel with _$MarketplaceCategoryModel {
  const MarketplaceCategoryModel._();

  const factory MarketplaceCategoryModel({
    @Default(0) int id,
    @Default('') String slug,
    @Default('') String name,
  }) = _MarketPlaceCategoryModel;

  factory MarketplaceCategoryModel.fromJson(dynamic json) =>
      _$MarketplaceCategoryModelFromJson(json);
}
