import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/view_post_repository_interface.dart';
import '../models/user_product_model.dart';
import '../services/view_post_api.dart';

@LazySingleton(as: IViewPostRepository)
class ViewPostRepository implements IViewPostRepository {
  final ViewPostApi _api;

  ViewPostRepository(this._api);

  @override
  Future<Result<UserProductModel, ApiError>> postDetail(int productId,
      {CancelToken? token}) async {
    return await _api
        .postDetail(productId, token)
        .tryGet((response) => response.data);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deletePost(int productId, {CancelToken? token}) async {
    return await _api
        .deletePost(productId, token)
        .tryGet((response) => response);
  }
}
