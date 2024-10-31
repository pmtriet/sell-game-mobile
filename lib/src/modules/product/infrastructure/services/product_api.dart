import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';

import '../../../buy/infrastructor/models/category_product.dart';
import '../model/suggest_product_model.dart';

part 'product_api.g.dart';

@RestApi()
@injectable
abstract class ProductApi {
  @factoryMethod
  factory ProductApi(Dio dio) = _ProductApi;

  @GET('/v1/products/{id}')
  Future<SingleApiResponse<ProductModel>> productDetail(
    @Path('id') int id,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/products/detail/{id}')
  Future<ListApiResponse<SuggestProductModel>> suggestProducts(
    @Path('id') int id,
    @CancelRequest() CancelToken? cancelToken,
  );
  
}
