import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../transaction_history/infrastructure/models/order_model.dart';
import 'my_rating_product_model.dart';

part 'rated_model.freezed.dart';
part 'rated_model.g.dart';

@freezed
class RatedModel with _$RatedModel {
  const factory RatedModel({
    @Default(0) int id,
    @Default('') String content,
    @Default(0) int star,
    @Default('') String createdAt,
    @Default(AccountModel()) AccountModel recipent,    
    @Default(MyRatingProductModel()) MyRatingProductModel product,   
  }) = _RatedModel;

  factory RatedModel.fromJson(Map<String, dynamic> json) =>
      _$RatedModelFromJson(json);
}

