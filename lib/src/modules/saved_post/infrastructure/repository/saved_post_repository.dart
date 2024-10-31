import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/saved_post_repository_interface.dart';
import '../model/saved_post_model.dart';
import '../service/saved_post_api.dart';

@LazySingleton(as: ISavedPostRepository)
class SavedPostRepository implements ISavedPostRepository {
  final SavedPostApi _api;

  SavedPostRepository(this._api);

  @override
  Future<Result<PagingApiResponse<SavedPostModel>, ApiError>> getSavedPosts(
      {int? page, CancelToken? token}) async {
    return await _api.getSavedPosts(page, token).tryGet((response) => response);
  }
  @override
  Future<Result<StatusApiResponse, ApiError>> deleteFavouriteProduct(int val,
      {CancelToken? token}) async {
    return await _api
        .deleteSavedProduct(val, token)
        .tryGet((response) => response);
  }
}
