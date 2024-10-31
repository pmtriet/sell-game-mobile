import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/buyer_rating_model.dart';
import '../models/no_rating_model.dart';
import '../models/rated_model.dart';

part 'my_rating_api.g.dart';

@RestApi()
@injectable
abstract class MyRatingApi {
  @factoryMethod
  factory MyRatingApi(Dio dio) = _MyRatingApi;

  @GET('/v1/ratings/products-to-rate')
  Future<PagingApiResponse<NoRatingModel>> productsToRate(
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/ratings')
  Future<PagingApiResponse<RatedModel>> ratedProducts(
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );
  
  @GET('/v1/ratings/from-buyer')
  Future<PagingApiResponse<BuyerRatingModel>> buyerRating(
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );
}