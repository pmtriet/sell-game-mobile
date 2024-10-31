import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/extensions/date_time_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../domain/interface/transaction_history_repository_interface.dart';
import '../../infrastructure/models/payment_history_model.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';

class PaymentCubit extends Cubit<PaymentState>
    with CancelableBaseBloc<PaymentState> {
  final ITransactionHistoryRepository _repository;
  PaymentCubit(this._repository)
      : super(const PaymentState.initial(null, null, true, null)) {
    getPaymentHistory();
  }

  late MetaApiResponse meta;

  DateTime paymentStarttime = DateTime.now().subtract(const Duration(days: 7));
  DateTime paymentLasttime = DateTime.now();

  List<PaymentHistoryModel> paymentHistories = [];

  Future<void> getPaymentHistory() async {
    //api get payments history
    final result = await _repository.paymentHistory(
        startDay: paymentStarttime.format(DateFormatType.yyyyMMdd),
        endDay: paymentLasttime.format(DateFormatType.yyyyMMdd));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      paymentHistories = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(paymentStarttime, paymentLasttime, false, paymentHistories));
  }

  Future<void> refresh() async {
    getPaymentHistory();
  }

  Future<void> loadmore() async {
    //call api
    if (meta.page < meta.totalPages) {
      //call api
      final result = await _repository.paymentHistory(
          page: meta.page + 1,
          startDay: paymentStarttime.format(DateFormatType.yyyyMMdd),
          endDay: paymentLasttime.format(DateFormatType.yyyyMMdd));

      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        paymentHistories.addAll(List.of(response.data));

        meta = response.meta;

        emit(_Initial(
            paymentStarttime, paymentLasttime, false, paymentHistories));
      }
    }
  }

  Future<void> setTimePicker(DateTime start, DateTime end) async {
    emit(_Initial(start, end, true, paymentHistories));
    paymentStarttime = start;
    paymentLasttime = end;

    //get list payments from start to end from api
    final result = await _repository.paymentHistory(
        startDay: paymentStarttime.format(DateFormatType.yyyyMMdd),
        endDay: paymentLasttime.format(DateFormatType.yyyyMMdd));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      paymentHistories = List.of(response.data);

      meta = response.meta;
    }
    emit(_Initial(start, end, false, paymentHistories));
  }
}
