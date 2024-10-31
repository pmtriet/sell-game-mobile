part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial(bool isLoading, List<NotificationModel>? notifications) = _Initial;
}
