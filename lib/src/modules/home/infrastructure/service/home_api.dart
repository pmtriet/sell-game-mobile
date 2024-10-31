import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/banner_models/banner_model.dart';
import '../models/category_models/category_and_products_model.dart';
import '../models/category_models/category_model.dart';
import '../models/suggesting_product_model/list_suggesting_products_model.dart';

part 'home_api.g.dart';

@RestApi()
@injectable
abstract class HomeApi {
  @factoryMethod
  factory HomeApi(Dio dio) = _HomeApi;

  @GET('/v1/banners')
  Future<ListApiResponse<BannerModel>> banners(
    @Query('type') String type,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/categories')
  Future<ListApiResponse<CategoryModel>> categories(
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/categories/get-product-follow-category')
  Future<ProductsByCategoryPagingApiResponse<CategoryAndProductsModel>>
      productsByCategory(
    @Query('type') String type,
    @CancelRequest() CancelToken? cancelToken,
  );
  @GET('/v1/products/section')
  Future<ListApiResponse<ListSuggestingProductModel>> suggestingProducts(
    @Query('type') String type,
    @CancelRequest() CancelToken? cancelToken,
  );
}
