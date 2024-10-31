part of '../pages/notification_page.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(authenticated: (_) {
          context.read<NotificationCubit>().fetchNotificationData();
        });
      },
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.w, 0, 12.w),
                child: Text(
                  context.s.notification.toUpperCase(),
                  style: context.textTheme.displayLarge,
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListNotificationsWidget(
                      notifications: state.notifications ?? [],
                      refresh: context.read<NotificationCubit>().refresh,
                      loadmore: context.read<NotificationCubit>().loadmore,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
