import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/setting_account_repository_interface.dart';
import '../../domain/request_models/change_password_request.dart';
import '../service/setting_account_api.dart';

@Injectable(as: ISettingAccountRepository)
class SettingAccountRepository implements ISettingAccountRepository {
  final SettingAccountApi _api;
  SettingAccountRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> changePassword(
    ChangePasswordRequest request, {
    CancelToken? token,
  }) async {
    return await _api.register(request, token).tryGet((response) => response);
  }
}
