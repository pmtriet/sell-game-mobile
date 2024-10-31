
import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_data_model.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String content,
    @Default(NotificationDataModel()) NotificationDataModel data,
    @Default('') String type,
    @Default(false) bool isRead,
    @Default('') String createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(dynamic json) =>
      _$NotificationModelFromJson(json);
}
