import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../infrastructure/models/post_status_model.dart';

abstract class IManagementPostRepository {
  Future<Result<PagingApiResponse<MarketplaceProductModel>, ApiError>>
      getProductsManagementPost(String status,
          {int? page, CancelToken? token});
   Future<Result<List<PostStatusModel>, ApiError>>
      getManagementPost(
          {CancelToken? token});
}