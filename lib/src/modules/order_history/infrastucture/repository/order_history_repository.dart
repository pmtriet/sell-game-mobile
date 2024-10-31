import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/order_history_repository_interface.dart';
import '../model/transaction_model.dart';
import '../service/order_history_api.dart';

@LazySingleton(as: IOrderHistoryRepository)
class OrderHistoryRepository implements IOrderHistoryRepository {
  final OrderHistoryApi _api;

  OrderHistoryRepository(this._api);

  @override
  Future<Result<TransactionModel, ApiError>> transaction(int transactionId,
      {CancelToken? token}) async {
    return await _api.transaction(transactionId, token).tryGet((response) => response.data);
  }
}
