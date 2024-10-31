import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../infrastucture/model/transaction_model.dart';

abstract class IOrderHistoryRepository {
  Future<Result<TransactionModel, ApiError>> transaction(int transactionId,
      {CancelToken? token});
}
