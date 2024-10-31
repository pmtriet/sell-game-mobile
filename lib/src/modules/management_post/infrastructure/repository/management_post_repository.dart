import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/management_post_repository_interface.dart';
import '../models/post_status_model.dart';
import '../service/management_post_api.dart';

@LazySingleton(as: IManagementPostRepository)
class ManagementPostRepository implements IManagementPostRepository {
  final ManagementPostApi _api;

  ManagementPostRepository(this._api);

  @override
  Future<Result<PagingApiResponse<MarketplaceProductModel>, ApiError>>
      getProductsManagementPost(String status,
          {int? page, CancelToken? token}) async {
    return await _api
        .getProductsManagementPost(status, page, token)
        .tryGet((response) => response);
  }

  @override
  Future<Result<List<PostStatusModel>, ApiError>> getManagementPost(
      {CancelToken? token}) async {
    return await _api
        .getManagementPost(token)
        .tryGet((response) => response.data);
  }
}
