import 'package:freezed_annotation/freezed_annotation.dart';
import 'suggesting_product_model.dart';

part 'list_suggesting_products_model.freezed.dart';
part 'list_suggesting_products_model.g.dart';

@freezed
class ListSuggestingProductModel with _$ListSuggestingProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory ListSuggestingProductModel({
    @Default([]) List<SuggestingProductModel> data,
  }) = _ListSuggestingProductModel;

  factory ListSuggestingProductModel.fromJson(Map<String, dynamic> json) =>
      _$ListSuggestingProductModelFromJson(json);
}