part of 'orders_cubit.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial(DateTime? start, DateTime? end,
      bool isLoading, List<OrderModel>? orders) = _Initial;
}
