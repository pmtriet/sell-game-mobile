import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data_model.freezed.dart';
part 'notification_data_model.g.dart';

@freezed
class NotificationDataModel with _$NotificationDataModel {
  const NotificationDataModel._();

  const factory NotificationDataModel({
    @Default(0) int id,
  }) = _NotificationDataModel;

  factory NotificationDataModel.fromJson(dynamic json) =>
      _$NotificationDataModelFromJson(json);
}