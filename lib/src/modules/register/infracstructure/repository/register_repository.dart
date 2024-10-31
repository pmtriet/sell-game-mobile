import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/register_repository_interface.dart';
import '../../domain/request_models/register_request.dart';
import '../service/register_api.dart';

@Injectable(as: IRegisterRepository)
class RegisterRepository implements IRegisterRepository {
  final RegisterApi _api;
  RegisterRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> register(
    RegisterRequest request, {
    CancelToken? token,
  }) async {
    return await _api
    .register(request, token)
    .tryGet((response) => response);
  }
}
