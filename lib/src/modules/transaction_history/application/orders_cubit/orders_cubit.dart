import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/extensions/date_time_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../domain/interface/transaction_history_repository_interface.dart';
import '../../infrastructure/models/order_model.dart';

part 'orders_state.dart';
part 'orders_cubit.freezed.dart';

class OrdersCubit extends Cubit<OrdersState>
    with CancelableBaseBloc<OrdersState> {
  final ITransactionHistoryRepository _repository;
  OrdersCubit(this._repository)
      : super(const OrdersState.initial(null, null, true, null)) {
    getOrderHistory();
  }

  late MetaApiResponse meta;

  DateTime orderStarttime = DateTime.now().subtract(const Duration(days: 7));
  DateTime orderLasttime = DateTime.now();

  List<OrderModel> orderHistories = [];

  Future<void> getOrderHistory() async {
    final result = await _repository.orderHistory(
        startDay: orderStarttime.format(DateFormatType.yyyyMMdd),
        endDay: orderLasttime.format(DateFormatType.yyyyMMdd));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      orderHistories = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(orderStarttime, orderLasttime, false, orderHistories));
  }

  Future<void> refreshOrders() async {
    getOrderHistory();
  }

  Future<void> loadmoreOrders() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.orderHistory(
          page: meta.page + 1,
          startDay: orderStarttime.format(DateFormatType.yyyyMMdd),
          endDay: orderLasttime.format(DateFormatType.yyyyMMdd));

      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        orderHistories.addAll(List.of(response.data));

        meta = response.meta;

        emit(_Initial(orderStarttime, orderLasttime, false, orderHistories));
      }
    }
  }

  Future<void> setTimePicker(DateTime start, DateTime end) async {
    emit(_Initial(start, end, true, orderHistories));
    orderStarttime = start;
    orderLasttime = end;

    final result = await _repository.orderHistory(
        startDay: orderStarttime.format(DateFormatType.yyyyMMdd),
        endDay: orderLasttime.format(DateFormatType.yyyyMMdd));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      orderHistories = List.of(response.data);

      meta = response.meta;
    }
    emit(_Initial(start, end, false, orderHistories));
  }
}
