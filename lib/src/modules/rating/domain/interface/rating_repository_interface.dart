import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/rating_request.dart';

abstract class IRatingRepository {
  Future<Result<StatusApiResponse, ApiError>> rating(RatingRequest request, {CancelToken? token});
}
