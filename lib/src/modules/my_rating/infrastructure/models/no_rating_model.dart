import 'package:freezed_annotation/freezed_annotation.dart';
import 'my_rating_product_model.dart';

part 'no_rating_model.freezed.dart';
part 'no_rating_model.g.dart';

@freezed
class NoRatingModel with _$NoRatingModel {
  const factory NoRatingModel({
    @Default(0) int id,
    @Default(0) int value,
    @Default(MyRatingProductModel()) MyRatingProductModel product,
    @Default('') String createdAt,
  }) = _NoRatingModel;

  factory NoRatingModel.fromJson(Map<String, dynamic> json) =>
      _$NoRatingModelFromJson(json);
}
