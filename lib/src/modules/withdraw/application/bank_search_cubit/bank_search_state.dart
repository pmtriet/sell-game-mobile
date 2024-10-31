part of 'bank_search_cubit.dart';

@freezed
class BankSearchState with _$BankSearchState {
  const factory BankSearchState.initial(bool isLoading, List<BankModel>? banks) = _Initial;
}
