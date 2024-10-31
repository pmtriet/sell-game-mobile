import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/rating_repository_interface.dart';
import '../models/rating_request.dart';
import '../service/rating_api.dart';

@LazySingleton(as: IRatingRepository)
class RatingRepository implements IRatingRepository {
  final RatingApi _api;

  RatingRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> rating(RatingRequest request,
      {CancelToken? token}) async {
    return await _api.rating(request, token).tryGet((response) => response);
  }
}
