import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/buyer_rating_model.dart';
import '../../infrastructure/models/no_rating_model.dart';
import '../../infrastructure/models/rated_model.dart';

abstract class IMyRatingRepository {
  Future<Result<PagingApiResponse<NoRatingModel>, ApiError>>
      productsToRate(String status,
          {int? page, CancelToken? token});

  Future<Result<PagingApiResponse<RatedModel>, ApiError>>
      ratedProducts(String status,
          {int? page, CancelToken? token});

  Future<Result<PagingApiResponse<BuyerRatingModel>, ApiError>>
      buyerRating(String status,
          {int? page, CancelToken? token});
}