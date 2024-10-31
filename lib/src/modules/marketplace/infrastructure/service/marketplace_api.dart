import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/marketplace_product_follow_shop_model.dart';

part 'marketplace_api.g.dart';

@RestApi()
@injectable
abstract class MarketplaceApi {
  @factoryMethod
  factory MarketplaceApi(Dio dio) = _MarketplaceApi;

  @GET('/v1/products/section?limit=4&type=C2C')
  Future<ListApiResponse<MarketplaceProductFollowShopModel>> productFollowShop(
    @CancelRequest() CancelToken? cancelToken,
  );
}
