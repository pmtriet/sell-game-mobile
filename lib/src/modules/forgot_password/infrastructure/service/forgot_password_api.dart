import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../model/forgot_password_request.dart';

part 'forgot_password_api.g.dart';

@RestApi()
@injectable
abstract class ForgotPasswordApi {
  @factoryMethod
  factory ForgotPasswordApi(Dio dio) = _ForgotPasswordApi;

  @POST('/v1/auth/forgot-password')
  Future<StatusApiResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
    @CancelRequest() CancelToken? cancelToken,
  );
}
