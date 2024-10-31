import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../infrastructure/models/shop_account_model.dart';

abstract class IShopProfileRepository {
  Future<Result<ShopAccountModel, ApiError>> getProfileShop(int shopId,
      {CancelToken? token});

  Future<Result<PagingApiResponse<MarketplaceProductModel>, ApiError>>
      getShopProducts(String status, int shopId,
          {int? page, CancelToken? token});

  Future<Result<StatusApiResponse, ApiError>> followShop(int shopId,
      {CancelToken? token});
}
