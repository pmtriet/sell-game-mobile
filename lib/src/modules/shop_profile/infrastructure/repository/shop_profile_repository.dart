import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/shop_profile_repository_interface.dart';
import '../models/shop_account_model.dart';
import '../service/shop_profile_api.dart';

@LazySingleton(as: IShopProfileRepository)
class ShopProfileRepository implements IShopProfileRepository {
  final ShopProfileApi _api;

  ShopProfileRepository(this._api);

  @override
  Future<Result<ShopAccountModel, ApiError>> getProfileShop(int shopId,
      {CancelToken? token}) async {
    return await _api
        .getProfileShop(shopId, token)
        .tryGet((response) => response.data);
  }

  @override
  Future<Result<PagingApiResponse<MarketplaceProductModel>, ApiError>>
      getShopProducts(String status, int shopId,
          {int? page, CancelToken? token}) async {
    return await _api
        .getShopProducts(status, shopId, page, token)
        .tryGet((response) => response);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> followShop(int shopId,
      {CancelToken? token}) async {
    return await _api.followShop(shopId, token).tryGet((response) => response);
  }
}
