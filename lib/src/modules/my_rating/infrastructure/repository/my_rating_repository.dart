import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../domain/interface/my_rating_repository_interface.dart';
import '../models/buyer_rating_model.dart';
import '../models/no_rating_model.dart';
import '../models/rated_model.dart';
import '../service/my_rating_api.dart';

@LazySingleton(as: IMyRatingRepository)
class MyRatingRepository implements IMyRatingRepository {
  final MyRatingApi _api;

  MyRatingRepository(this._api);

  @override
  Future<Result<PagingApiResponse<BuyerRatingModel>, ApiError>> buyerRating(
      {int? page, CancelToken? token}) async {
    return await _api.buyerRating(page, token).tryGet((response) => response);
  }

  @override
  Future<Result<PagingApiResponse<NoRatingModel>, ApiError>> productsToRate(
      {int? page, CancelToken? token}) async {
    return await _api
        .productsToRate(page, token)
        .tryGet((response) => response);
  }

  @override
  Future<Result<PagingApiResponse<RatedModel>, ApiError>> ratedProducts(
      {int? page, CancelToken? token}) async {
    return await _api.ratedProducts(page, token).tryGet((response) => response);
  }
}
