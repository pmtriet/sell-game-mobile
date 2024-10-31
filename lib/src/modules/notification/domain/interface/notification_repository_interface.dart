import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/notification_model.dart';

abstract class INotificationRepository {
  Future<Result<PagingApiResponse<NotificationModel>, ApiError>>
      notification({int? page, CancelToken? token});
}
