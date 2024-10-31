import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../buy/infrastructor/models/category_product.dart';

part 'search_api.g.dart';

@RestApi()
@injectable
abstract class SearchApi {
  @factoryMethod
  factory SearchApi(Dio dio) = _SearchApi;

  @GET('/v1/products/product-search')
  Future<PagingApiResponse<ProductModel>> searchProducts(
    @Query('page') int page, // Page number
    @Query('limit') int limit, // Limit per page
    @Query('keyword') String keyword, // Keyword for search
    @Query('saleOff') bool? saleOff,
    @Query('price') String? price,
    @Query('rank') String? rank,
    @CancelRequest() CancelToken? cancelToken,
  );
}
