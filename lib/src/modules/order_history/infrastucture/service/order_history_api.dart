import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../model/transaction_model.dart';

part 'order_history_api.g.dart';

@RestApi()
@injectable
abstract class OrderHistoryApi {
  @factoryMethod
  factory OrderHistoryApi(Dio dio) = _OrderHistoryApi;

  @GET('/v1/transactions/{transactionId}')
  Future<SingleApiResponse<TransactionModel>> transaction(
    @Path('transactionId') int transactionId,
    @CancelRequest() CancelToken? cancelToken,
  );
}
