import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../domain/request_models/change_password_request.dart';

part 'setting_account_api.g.dart';

@RestApi()
@injectable
abstract class SettingAccountApi {
  @factoryMethod
  factory SettingAccountApi(Dio dio) = _SettingAccountApi;

  @POST('/v1/auth/change-password')
  Future<StatusApiResponse> register(
    @Body() ChangePasswordRequest request,
    @CancelRequest() CancelToken? cancelToken,
  );
}
