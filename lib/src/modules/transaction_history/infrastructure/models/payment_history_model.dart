import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/payment_history.dart';

part 'payment_history_model.freezed.dart';
part 'payment_history_model.g.dart';

@freezed
class PaymentHistoryModel with _$PaymentHistoryModel implements PaymentHistory  {
  @JsonSerializable(explicitToJson: true)
  const factory PaymentHistoryModel({
    @Default(0) int id,
    @Default('') String code,
    @Default(0) int value,
    @Default('') String type,
    @Default('') String status,
    @Default('') String createdAt,
  }) = _PaymentHistoryModel;

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryModelFromJson(json);
}