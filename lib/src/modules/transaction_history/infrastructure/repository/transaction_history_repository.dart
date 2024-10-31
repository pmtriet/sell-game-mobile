import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/transaction_history_repository_interface.dart';
import '../models/order_model.dart';
import '../models/payment_history_model.dart';
import '../service/transaction_history_api.dart';

@LazySingleton(as: ITransactionHistoryRepository)
class TransactionHistoryRepository implements ITransactionHistoryRepository {
  final TransactionHistoryApi _api;

  TransactionHistoryRepository(this._api);

  @override
  Future<Result<PagingApiResponse<PaymentHistoryModel>, ApiError>>
      paymentHistory(
          {int? page,
          String? startDay,
          String? endDay,
          CancelToken? token}) async {
    return await _api
        .paymentHistory(page, startDay, endDay, token)
        .tryGet((response) => response);
  }

  @override
  Future<Result<PagingApiResponse<OrderModel>, ApiError>> orderHistory(
      {int? page, String? startDay, String? endDay, CancelToken? token}) async {
    return await _api
        .orderHistory(page, startDay, endDay, token)
        .tryGet((response) => response);
  }
}
