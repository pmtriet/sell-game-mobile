part of '../page/profile_page.dart';

class OrderManagementWidget extends StatelessWidget {
  const OrderManagementWidget({super.key, required this.isLoggedIn});
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
                      context.s.order_management,
                      style: context.textTheme.contentLarge,
                    ),
                  ],
                )),
            //purchase orders
            // MenuItemWidget(
            //   icon: Assets.icons.shoppingCart.svg(),
            //   content: context.s.purchase_order,
            //   onTap: isLoggedIn == true
            //       ? () {
            //           context.router.push(const OrderRoute());
            //         }
            //       : () {
            //           AppDialogs.show(
            //             type: AlertType.notice,
            //               content: context.s.please_login_to_use_utility);
            //         },
            // ),
            //transaction history
            MenuItemWidget(
              icon: Assets.icons.transactionHistory.svg(),
              content: context.s.transaction_history,
              onTap: isLoggedIn == true
                  ? () {
                      context.router.push(const TransactionHistoryRoute());
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
