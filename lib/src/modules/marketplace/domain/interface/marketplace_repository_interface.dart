import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../infrastructure/models/marketplace_product_follow_shop_model.dart';

abstract class IMarketplaceRepository {
  Future<Result<List<MarketplaceProductFollowShopModel>, ApiError>> productFollowShop(
      {CancelToken? token});
}
