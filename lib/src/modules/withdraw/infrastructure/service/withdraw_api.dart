import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../domain/request_models/withdraw_request.dart';
import '../models/bank_account_model.dart';

part 'withdraw_api.g.dart';

@RestApi()
@injectable
abstract class WithdrawApi {
  @factoryMethod
  factory WithdrawApi(Dio dio) = _WithdrawApi;

  @GET('/v1/wallet-bank/get-all-wallet-bank')
  Future<ListApiResponse<BankAccountModel>> walletBanks(
    @CancelRequest() CancelToken? cancelToken,
  );

  @POST('/v1/wallet-bank/create-wallet-bank')
  Future<StatusApiResponse> createWallet(
    @Body() BankAccountModel request,
    @CancelRequest() CancelToken? cancelToken,
  );

  @DELETE('/v1/wallet-bank/delete-wallet-bank/{walletId}')
  Future<StatusApiResponse> deleteWallet(
    @Path('walletId') int id,
    @CancelRequest() CancelToken? cancelToken,
  );

  @POST('/v1/with-draw/with-draw')
  Future<StatusApiResponse> withdraw(
    @Body() WithdrawRequest request,
    @CancelRequest() CancelToken? cancelToken,
  );
}
