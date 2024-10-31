part of '../page/profile_page.dart';

class SellManagementWidget extends StatelessWidget {
  const SellManagementWidget({super.key, required this.isLoggedIn});
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
                      context.s.sell_management,
                      style: context.textTheme.contentLarge,
                    ),
                  ],
                )),
            //post magnagement
            MenuItemWidget(
              icon: Assets.icons.postManagement.svg(),
              content: context.s.post_management,
              onTap: isLoggedIn == true
                  ? () {
                      context.router.push( ManagementPostRoute());
                    }
                  : () {
                      AppDialogs.show(
                          type: AlertType.notice,
                          content: context.s.please_login_to_use_utility,
                          );
                    },
            ),

            //withdraw
            MenuItemWidget(
              icon: Assets.icons.withdraw.svg(),
              content: context.s.withdraw,
              onTap: isLoggedIn == true
                  ? () {
                      context.router.push(const WithdrawMoneyRoute());
                    }
                  : () {
                      AppDialogs.show(
                          type: AlertType.notice,
                          content: context.s.please_login_to_use_utility);
                    },
            ),
          ]),
    );
  }
}
