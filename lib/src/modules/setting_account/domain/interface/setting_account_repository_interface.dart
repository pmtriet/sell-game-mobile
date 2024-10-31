import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../request_models/change_password_request.dart';

abstract class ISettingAccountRepository {
 Future<Result<StatusApiResponse, ApiError>> changePassword(
    ChangePasswordRequest requestm, {
    CancelToken? token,
  });
}