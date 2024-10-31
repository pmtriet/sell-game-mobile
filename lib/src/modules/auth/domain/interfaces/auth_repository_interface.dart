import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/auth_token.dart';
import '../../infrastructure/models/user_model.dart';
import '../entities/user.dart';
import '../request_models/login_request_models/login_request.dart';

abstract class IAuthRepository {
  User? getUser();
  Future setUser(User? val);
  Future<String?> getAccessToken();
  Future setAccessToken(String? val);
  Future<String?> getRefreshToken();
  Future setRefreshToken(String? val);
  //return String accessToken || ApiError
  Future<Result<User, ApiError>> login(
    LoginRequest requestm, {
    CancelToken? token,
  });
  Future logout({CancelToken? token});
  Future<Result<List<User>, ApiError>> users({CancelToken? token});
  Future<Result<User, ApiError>> user(String id, {CancelToken? token});
  Future<Result<AuthToken, ApiError>> renewAccessToken({CancelToken? token});
  Future<Result<UserModel, ApiError>> getProfile({CancelToken? token});

  Future<Result<List<int>, ApiError>> getFavouriteProducts();
  Future<Result<StatusApiResponse, ApiError>> setFavouriteProduct(int val);
  Future<Result<StatusApiResponse, ApiError>> deleteFavouriteProduct(int val);
}
