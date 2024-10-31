import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_request.freezed.dart';
part 'withdraw_request.g.dart';

@freezed
class WithdrawRequest with _$WithdrawRequest {
  const factory WithdrawRequest({
    @Default(0) int wdAmount,
    @Default(0) int bankId,
  }) = _WithdrawRequest;

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) => _$WithdrawRequestFromJson(json);
}
