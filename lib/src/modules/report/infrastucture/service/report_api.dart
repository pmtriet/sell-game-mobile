import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';

part 'report_api.g.dart';

@RestApi()
@injectable
abstract class ReportApi {
  @factoryMethod
  factory ReportApi(Dio dio) = _ReportApi;

  @POST('/v1/report')
  @MultiPart()
  Future<StatusApiResponse> report(
    @Part(name: 'transactionId') int transactionId,
    @Part(name: 'title') String title,
    @Part(name: 'content') String content,
    @Part(name: 'images') List<MultipartFile> images,
    @CancelRequest() CancelToken? cancelToken,
  );
}
