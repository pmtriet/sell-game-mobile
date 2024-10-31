import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../models/post_status_model.dart';

part 'management_post_api.g.dart';

@RestApi()
@injectable
abstract class ManagementPostApi {
  @factoryMethod
  factory ManagementPostApi(Dio dio) = _ManagementPostApi;

  @GET('/v1/auth/get-manager-posting')
  Future<ListApiResponse<PostStatusModel>> getManagementPost(
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/products/account')
  Future<PagingApiResponse<MarketplaceProductModel>> getProductsManagementPost(
    @Query('status') String status,
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );
}