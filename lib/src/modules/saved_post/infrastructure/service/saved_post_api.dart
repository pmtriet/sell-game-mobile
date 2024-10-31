import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../model/saved_post_model.dart';

part 'saved_post_api.g.dart';

@RestApi()
@injectable
abstract class SavedPostApi {
  @factoryMethod
  factory SavedPostApi(Dio dio) = _SavedPostApi;

  @GET('/v1//bookmarks/products')
  Future<PagingApiResponse<SavedPostModel>> getSavedPosts(
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );

  @DELETE('/v1//bookmarks/{productId}')
  Future<StatusApiResponse> deleteSavedProduct(
    @Path('productId') int productId,
    @CancelRequest() CancelToken? cancelToken,
  );
}