
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../request_models/register_request.dart';

abstract class IRegisterRepository {
 Future<Result<StatusApiResponse, ApiError>> register(
    RegisterRequest requestm, {
    CancelToken? token,
  });
}