import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../management_post/infrastructure/models/post_status_model.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../../shop_profile/infrastructure/models/shop_account_model.dart';

abstract class IPersonalProfileRepository {
  Future<Result<PagingApiResponse<MarketplaceProductModel>, ApiError>>
      getProductsManagementPost(String status,
          {int? page, CancelToken? token});
   Future<Result<List<PostStatusModel>, ApiError>>
      getManagementPost(
          {CancelToken? token});

  Future<Result<ShopAccountModel, ApiError>> getProfileShop(int shopId,
      {CancelToken? token});
}