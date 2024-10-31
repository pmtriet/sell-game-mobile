import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/bank.dart';

part 'bank_model.freezed.dart';
part 'bank_model.g.dart';

@freezed
class BankModel with _$BankModel implements Bank {
  const BankModel._();

  const factory BankModel({
    @Default('') String bin,
    @Default('') String shortName,
    @Default('') String name,
    @Default('') String bankLogoUrl,
  }) = _BankModel;

  factory BankModel.fromJson(Map<String, dynamic> json) =>
      _$BankModelFromJson(json);
}
