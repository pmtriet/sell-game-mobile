part of '../pages/notification_page.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key, required this.notificationType});
  final String notificationType;

  @override
  Widget build(BuildContext context) {
    var notiType = getNotificationTypeFromString(notificationType);
    return Container(
        height: 48.w,
        width: 48.w,
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(UIConstants.imgRadius),
        ),
        child: Center(
          child: getIconFromNotificationType(notiType),
        ));
  }
}
