part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial(DateTime? start, DateTime? end,
      bool isLoading, List<PaymentHistoryModel>? transactions) = _Initial;
}
