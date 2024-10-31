import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/model/saved_post_model.dart';

abstract class ISavedPostRepository {
  Future<Result<PagingApiResponse<SavedPostModel>, ApiError>>
      getSavedPosts({int? page, CancelToken? token});
   Future<Result<StatusApiResponse, ApiError>> deleteFavouriteProduct(int val);
}
