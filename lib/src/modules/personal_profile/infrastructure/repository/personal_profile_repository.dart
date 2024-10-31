import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../management_post/infrastructure/models/post_status_model.dart';
import '../../../management_post/infrastructure/service/management_post_api.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../../shop_profile/infrastructure/models/shop_account_model.dart';
import '../../../shop_profile/infrastructure/service/shop_profile_api.dart';
import '../../domain/interface/personal_profile_repository_interface.dart';

@LazySingleton(as: IPersonalProfileRepository)
class PersonalProfileRepository implements IPersonalProfileRepository {
  final ManagementPostApi _api;
  final ShopProfileApi _shopApi;

  PersonalProfileRepository(this._api, this._shopApi);

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

  @override
  Future<Result<ShopAccountModel, ApiError>> getProfileShop(int shopId,
      {CancelToken? token}) async {
    return await _shopApi
        .getProfileShop(shopId, token)
        .tryGet((response) => response.data);
  }
}
