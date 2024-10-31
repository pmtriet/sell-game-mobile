import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/order_model.dart';
import '../models/payment_history_model.dart';

part 'transaction_history_api.g.dart';

@RestApi()
@injectable
abstract class TransactionHistoryApi {
  @factoryMethod
  factory TransactionHistoryApi(Dio dio) = _TransactionHistoryApi;

  @GET('/v1/transactions/payment-history')
  Future<PagingApiResponse<PaymentHistoryModel>> paymentHistory(
    @Query('page') int? page,
    @Query('startDay') String? startDay,
    @Query('endDay') String? endDay,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/transactions/order-history')
  Future<PagingApiResponse<OrderModel>> orderHistory(
    @Query('page') int? page,
    @Query('startDay') String? startDay,
    @Query('endDay') String? endDay,
    @CancelRequest() CancelToken? cancelToken,
  );
}
