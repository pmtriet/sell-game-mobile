import 'package:flutter/material.dart';
import '../../../generated/assets.gen.dart';

enum NotificationType {
  postRejected,
  postApproved,
  postSuccess,
  saleSuccess
}

NotificationType? getNotificationTypeFromString(String type) {
  switch (type) {
    case 'POST_APPROVED':
      return NotificationType.postApproved;
    case 'POST_REJECTED':
      return NotificationType.postRejected;
    case 'POST_SUCCESS':
      return NotificationType.postSuccess;
    case 'SALE_SUCCESS':
      return NotificationType.saleSuccess;
    default:
      return null;
  }
}

Widget getIconFromNotificationType(NotificationType? type) {
  switch (type) {
    case NotificationType.postApproved:
      return Assets.icons.approvedNotification.svg();
    case NotificationType.postRejected:
      return Assets.icons.rejectedNotification.svg();
    case NotificationType.postSuccess:
      return Assets.icons.postSuccess.svg();
    case NotificationType.saleSuccess:
      return Assets.icons.sellSuccess.svg();
    default:
      return const Icon(Icons.error);
  }
}