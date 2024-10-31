import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';

part 'suggest_product_model.freezed.dart';
part 'suggest_product_model.g.dart';

@freezed
class SuggestProductModel with _$SuggestProductModel {
  const factory SuggestProductModel({
    @Default('') String title,
    @Default([]) List<MarketplaceProductModel> data,
  }) = _SuggestProductModel;

  // fromJson and toJson methods
  factory SuggestProductModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestProductModelFromJson(json);
}