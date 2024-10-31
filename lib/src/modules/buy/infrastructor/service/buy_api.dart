import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../auth/infrastructure/models/user_model.dart';
import '../models/voucher_model.dart';

part 'buy_api.g.dart';

@RestApi()
@injectable
abstract class BuyApi {
  @factoryMethod
  factory BuyApi(Dio dio) = _BuyApi;

  @POST('/v1/transactions/purchase')
  Future<HttpResponse<void>> purchase(
    @Body() Map<String, dynamic> body,
    @CancelRequest() CancelToken? cancelToken,
  );

  @POST('/v1/voucher/find')
  Future<SingleApiResponse<VoucherModel>> findVoucher(
    @Body() Map<String, dynamic> body,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/auth/get-profile')
  Future<SingleApiResponse<UserModel>> profile(
      @CancelRequest() CancelToken? cancelToken);
}
