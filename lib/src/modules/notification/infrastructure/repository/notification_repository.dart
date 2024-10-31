import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/notification_repository_interface.dart';
import '../models/notification_model.dart';
import '../service/notification_api.dart';

@LazySingleton(as: INotificationRepository)
class NotificationRepository implements INotificationRepository {
  final NotificationApi _api;

  NotificationRepository(this._api);

  @override
  Future<Result<PagingApiResponse<NotificationModel>, ApiError>> notification(
      {int? page, CancelToken? token}) async {
    return await _api.notification(page, token).tryGet((response) => response);
  }
}
