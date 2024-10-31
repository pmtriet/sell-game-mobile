import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../models/shop_account_model.dart';

part 'shop_profile_api.g.dart';

@RestApi()
@injectable
abstract class ShopProfileApi {
  @factoryMethod
  factory ShopProfileApi(Dio dio) = _ShopProfileApi;

  @GET('/v1/auth/get-profile-shop/{shopId}')
  Future<SingleApiResponse<ShopAccountModel>> getProfileShop(
    @Path('shopId') int shopId,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/auth/get-info-product-user')
  Future<PagingApiResponse<MarketplaceProductModel>> getShopProducts(
    @Query('status') String status,
    @Query('userId') int userId,
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );

  @PATCH('/v1/auth/follow-shop/{shopId}')
  Future<StatusApiResponse> followShop(
    @Path('shopId') int shopId,
    @CancelRequest() CancelToken? cancelToken,
  );
}