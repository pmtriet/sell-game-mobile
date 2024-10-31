import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction_product_model.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel{
  const TransactionModel._();

  const factory TransactionModel({
    @Default(0) int id,
    @Default('') String code,
    @Default(0) int voucherDiscount,
    @Default('') String voucherCode,
    @Default(0) int value,
    @Default('') String createdAt,
    @Default(TransactionProductModel()) TransactionProductModel product,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
