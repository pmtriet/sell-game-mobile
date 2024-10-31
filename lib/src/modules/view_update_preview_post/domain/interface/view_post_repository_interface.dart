import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/user_product_model.dart';

abstract class IViewPostRepository {
  Future<Result<UserProductModel, ApiError>> postDetail(int productId,
      {CancelToken? token});
  Future<Result<StatusApiResponse, ApiError>> deletePost(int productId,
      {CancelToken? token});
}
