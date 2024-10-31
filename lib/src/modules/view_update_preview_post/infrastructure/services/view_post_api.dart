import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/user_product_model.dart';

part 'view_post_api.g.dart';

@RestApi()
@injectable
abstract class ViewPostApi {
  @factoryMethod
  factory ViewPostApi(Dio dio) = _ViewPostApi;

  @GET('/v1/products/get-detail-info/{id}')
  Future<SingleApiResponse<UserProductModel>> postDetail(
    @Path('id') int id,
    @CancelRequest() CancelToken? cancelToken,
  );

  @DELETE('/v1/products/{id}')
  Future<StatusApiResponse> deletePost(
    @Path('id') int id,
    @CancelRequest() CancelToken? cancelToken,
  );
}
