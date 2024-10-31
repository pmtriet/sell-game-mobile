part of 'withdraw_money_cubit.dart';

@freezed
class WithdrawMoneyState with _$WithdrawMoneyState {
  const factory WithdrawMoneyState.initial(int? balance, int? numberRemaining, List<BankAccountModel>? bankAccounts, BankAccountModel? activeBank, BankAccountModel? deleteBank, String? error, bool? success, bool? isLoading) = _Initial;

}
