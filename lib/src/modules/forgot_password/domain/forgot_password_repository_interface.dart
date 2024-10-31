import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../infrastructure/model/forgot_password_request.dart';

abstract class IForgotPasswordRepository {
  Future<Result<StatusApiResponse, ApiError>> forgorPassword(
    ForgotPasswordRequest request, {
    CancelToken? token,
  });
}
