part of '../page/profile_page.dart';

class OtherWidget extends StatelessWidget {
  const OtherWidget({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 48.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.s.other,
                      style: context.textTheme.contentLarge,
                    ),
                  ],
                )),
            //account setting
            MenuItemWidget(
                icon: Assets.icons.setting.svg(),
                content: context.s.account_setting,
                disableColor: true,
                onTap: isLoggedIn == true
                    ? () {
                        context.router.push(const SettingAccountRoute());
                      }
                    : () {
                        AppDialogs.show(
                            type: AlertType.notice,
                            content: context.s.please_login_to_use_utility);
                      }),
            //help
            MenuItemWidget(
              icon: Assets.icons.help.svg(),
              content: context.s.help,
              disableColor: true,
              onTap: () {
                //TODO: help
              },
            ),
            //log out
            if (isLoggedIn)
              MenuItemWidget(
                icon: Assets.icons.logout.svg(),
                content: context.s.logout,
                disableColor: true,
                onTap: () => AppDialogs.show(
                  type: AlertType.warning,
                  content: context.s.confirm_logout,
                  action1: () => getIt<AuthCubit>().logout(),
                ),
              ),
          ]),
    );
  }
}
