import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../transaction_history/infrastructure/models/order_model.dart';
import 'my_rating_product_model.dart';

part 'buyer_rating_model.freezed.dart';
part 'buyer_rating_model.g.dart';

@freezed
class BuyerRatingModel with _$BuyerRatingModel {
  const factory BuyerRatingModel({
    @Default(0) int id,
    @Default('') String content,
    @Default(0) int star,
    @Default('') String createdAt,
    @Default(AccountModel()) AccountModel account,    
    @Default(MyRatingProductModel()) MyRatingProductModel product,   
  }) = _BuyerRatingModel;

  factory BuyerRatingModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerRatingModelFromJson(json);
}
