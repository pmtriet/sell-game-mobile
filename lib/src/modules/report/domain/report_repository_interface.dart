
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../core/infrastructure/datasources/remote/api/base/api_response.dart';

abstract class IReportRepository {
  Future<Result<StatusApiResponse, ApiError>> report(
    int transactionId,
    String title,
    String content,
    List<MultipartFile> images, {
    CancelToken? token,
  });
}
