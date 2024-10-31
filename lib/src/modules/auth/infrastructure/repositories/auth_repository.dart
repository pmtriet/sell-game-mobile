import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/logger.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../domain/entities/user.dart';
import '../../domain/interfaces/auth_repository_interface.dart';
import '../../domain/request_models/login_request_models/login_request.dart';
import '../models/auth_token.dart';
import '../models/user_model.dart';
import '../service/auth_client.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthClient _client;

  AuthRepository(this._client);

  @override
  UserModel? getUser() => Storage.user;

  @override
  Future setUser(User? val) async {
    if (val is UserModel?) {
      return Storage.setUser(val);
    }
  }

  @override
  Future<String?> getAccessToken() => Storage.accessToken;

  @override
  Future setAccessToken(String? val) => Storage.setAccessToken(val);

  @override
  Future<Result<UserModel, ApiError>> login(
    LoginRequest request, {
    CancelToken? token,
  }) async {
    var result = _client.login(request, token);
    return result.tryGet((response) => response.data);
  }

  @override
  Future logout({CancelToken? token}) async {
    await Future.delayed(1.seconds);
    await setUser(null);
    await setAccessToken(null);
  }

  @override
  Future<Result<List<UserModel>, ApiError>> users({CancelToken? token}) async {
    return await _client.users(token).tryGet((response) => response.data);
  }

  @override
  Future<Result<UserModel, ApiError>> user(String id,
      {CancelToken? token}) async {
    return await _client.user(id, token).tryGet((response) => response.data);
  }

  @override
  Future<String?> getRefreshToken() => Storage.refreshToken;

  @override
  Future setRefreshToken(String? val) => Storage.setAccessToken(val);

  @override
  Future<Result<AuthToken, ApiError>> renewAccessToken(
      {CancelToken? token}) async {
    final refreshToken = await Storage.refreshToken ?? '';
    return await _client
        .refreshToken({'refreshToken': refreshToken}, token).tryGet((response) {
      logger.d('LOGGER: ${response.data}');
      return response.data;
    });
  }

  @override
  Future<Result<UserModel, ApiError>> getProfile({CancelToken? token}) async {
    return await _client.getProfile(token).tryGet((response) => response.data);
  }

  @override
  Future<Result<List<int>, ApiError>> getFavouriteProducts(
      {CancelToken? token}) async {
    return await _client
        .getFavouriteProducts(token)
        .tryGet((response) => response.data);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> setFavouriteProduct(int val,
      {CancelToken? token}) async {
    return await _client
        .setFavouriteProduct(val, token)
        .tryGet((response) => response);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteFavouriteProduct(int val,
      {CancelToken? token}) async {
    return await _client
        .deleteFavouriteProduct(val, token)
        .tryGet((response) => response);
  }
}
