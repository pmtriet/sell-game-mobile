
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/bank_account.dart';
import 'bank_model.dart';

part 'bank_account_model.freezed.dart';
part 'bank_account_model.g.dart';

@freezed
class BankAccountModel with _$BankAccountModel implements BankAccount {
  const BankAccountModel._();

  const factory BankAccountModel({
    @Default(0) int id,
    @Default('') String bin,
    @Default('') String bankNumber,
    @Default('') String nameOwn,
    @Default(BankModel()) BankModel? bank,
  }) = _BankAccountModel;

  factory BankAccountModel.fromJson(Map<String, dynamic> json) =>
      _$BankAccountModelFromJson(json);
}
