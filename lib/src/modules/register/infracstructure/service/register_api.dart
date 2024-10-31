import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../domain/request_models/register_request.dart';

part 'register_api.g.dart';

@RestApi()
@injectable
abstract class RegisterApi {
  @factoryMethod
  factory RegisterApi(Dio dio) = _RegisterApi;

  @POST('/v1/auth/register')
  Future<StatusApiResponse> register(
    @Body() RegisterRequest request,
    @CancelRequest() CancelToken? cancelToken,
  );
}
