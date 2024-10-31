import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../models/buyer_rating_model.dart';
import '../../models/no_rating_model.dart';
import '../../models/rated_model.dart';

abstract class IMyRatingRepository {
  Future<Result<PagingApiResponse<NoRatingModel>, ApiError>>
      productsToRate(
          {int? page, CancelToken? token});

  Future<Result<PagingApiResponse<RatedModel>, ApiError>>
      ratedProducts(
          {int? page, CancelToken? token});

  Future<Result<PagingApiResponse<BuyerRatingModel>, ApiError>>
      buyerRating(
          {int? page, CancelToken? token});
}