import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/rating_request.dart';
part 'rating_api.g.dart';

@RestApi()
@injectable
abstract class RatingApi {
  @factoryMethod
  factory RatingApi(Dio dio) = _RatingApi;

  @POST('/v1/ratings')
  Future<StatusApiResponse> rating(
    @Body() RatingRequest request,
    @CancelRequest() CancelToken? cancelToken,
  );
}