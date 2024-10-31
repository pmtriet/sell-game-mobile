import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/order_model.dart';
import '../../infrastructure/models/payment_history_model.dart';

abstract class ITransactionHistoryRepository {
  Future<Result<PagingApiResponse<PaymentHistoryModel>, ApiError>>
      paymentHistory(
          {int? page, String? startDay, String? endDay, CancelToken? token});

  Future<Result<PagingApiResponse<OrderModel>, ApiError>> orderHistory(
      {int? page, String? startDay, String? endDay, CancelToken? token});
}
