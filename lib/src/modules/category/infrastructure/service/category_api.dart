import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../home/infrastructure/models/category_models/category_and_products_model.dart';

part 'category_api.g.dart';

@RestApi()
@injectable
abstract class CategoryApi {
  @factoryMethod
  factory CategoryApi(Dio dio) = _CategoryApi;

  @GET('/v1/categories/get-product-follow-category')
  Future<ProductsByCategoryPagingApiResponse<CategoryAndProductsModel>>
      productsByCategory(
    
    @Query('slug') String slug,
    @Query('type') String type,
    @Query('saleOff') bool? saleOff,
    @Query('rank') String? rank,
    @Query('title') String? title,
    @Query('price') String? price,
    @Query('minPrice') int? minPrice,
    @Query('maxPrice') int? maxPrice,
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );
}
