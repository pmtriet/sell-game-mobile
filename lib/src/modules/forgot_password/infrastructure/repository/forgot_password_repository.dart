import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/forgot_password_repository_interface.dart';
import '../model/forgot_password_request.dart';
import '../service/forgot_password_api.dart';

@Injectable(as: IForgotPasswordRepository)
class ForgotPasswordRepository implements IForgotPasswordRepository {
  final ForgotPasswordApi _api;

  ForgotPasswordRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> forgorPassword(
      ForgotPasswordRequest request,
      {CancelToken? token}) async {
    return await _api
        .forgotPassword(request, token)
        .tryGet((response) => response);
  }
}
