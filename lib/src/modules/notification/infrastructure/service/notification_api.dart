import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../models/notification_model.dart';

part 'notification_api.g.dart';

@RestApi()
@injectable
abstract class NotificationApi {
  @factoryMethod
  factory NotificationApi(Dio dio) = _NotificationApi;

  @GET('/v1/notifications')
  Future<PagingApiResponse<NotificationModel>> notification(
    @Query('page') int? page,
    @CancelRequest() CancelToken? cancelToken,
  );
}
