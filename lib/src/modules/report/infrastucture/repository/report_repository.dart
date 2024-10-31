import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/report_repository_interface.dart';
import '../service/report_api.dart';

@Injectable(as: IReportRepository)
class ReportRepository implements IReportRepository {
  final ReportApi _api;

  ReportRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> report(int transactionId,
      String title, String content, List<MultipartFile> images,
      {CancelToken? token}) async {
    return await _api
        .report(transactionId, title, content, images, token)
        .tryGet((response) => response);
  }
}
