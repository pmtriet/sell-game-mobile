part of 'order_history_cubit.dart';

@freezed
class OrderHistoryState with _$OrderHistoryState {
  const factory OrderHistoryState.loading() = _Loading;
  const factory OrderHistoryState.loaded(TransactionModel? transaction) =
      _Loaded;
}
