import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/marketplace_repository_interface.dart';
import '../models/marketplace_product_follow_shop_model.dart';
import '../service/marketplace_api.dart';

@LazySingleton(as: IMarketplaceRepository)
class MarketplaceRepository implements IMarketplaceRepository {
  final MarketplaceApi _api;

  MarketplaceRepository(this._api);

  @override
  Future<Result<List<MarketplaceProductFollowShopModel>, ApiError>> productFollowShop({CancelToken? token}) async {
    return await _api.productFollowShop(token).tryGet((response) => response.data );
  }
}