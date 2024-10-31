
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../auth/domain/entities/user.dart';

abstract class IProfileRepository {
  Future<String?> getAccessToken();
  User? getUser();
  Future setUser(User? val);
  Future<Result<StatusApiResponse, ApiError>> update(
    String? fullname,
    List<MultipartFile>? avatar,
    List<MultipartFile>? background,
    String? bio, {
    CancelToken? token,
  });
  Future<Result<User, ApiError>> profile({
    CancelToken? token,
  });
}
