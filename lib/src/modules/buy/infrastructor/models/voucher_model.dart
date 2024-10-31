import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_model.freezed.dart';
part 'voucher_model.g.dart';

@freezed
class VoucherModel with _$VoucherModel {
  const factory VoucherModel({
    required int productId,
    required String voucherTitle,
    required String voucherCode,
    required double discountPercent,
    required double priceReduced,
    required int originalPrice,
    required double saleOff,
    required int finalPrice,
  }) = _VoucherModel;

  factory VoucherModel.fromJson(Map<String, dynamic> json) => _$VoucherModelFromJson(json);
}
