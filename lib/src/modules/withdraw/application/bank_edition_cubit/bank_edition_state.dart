part of 'bank_edition_cubit.dart';

@freezed
class BankEditionState with _$BankEditionState {
  const factory BankEditionState.initial(BankModel? selectedBank, String? error, BankAccountModel? bankAccount, bool? isLoading) = _Initial;
}
