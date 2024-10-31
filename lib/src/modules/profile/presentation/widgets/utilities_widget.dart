part of '../page/profile_page.dart';

class UtilitiesWidget extends StatelessWidget {
  const UtilitiesWidget({super.key, required this.isLoggedIn});
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
                      context.s.utility,
                      style: context.textTheme.contentLarge,
                    ),
                  ],
                )),
            //saved posts
            MenuItemWidget(
              icon: Assets.icons.favourite.svg(),
              content: context.s.saved_post,
              onTap: isLoggedIn == true
                  ? () {
                      context.router.push(const SavedPostRoute());
                    }
                  : () {
                      AppDialogs.show(
                          type: AlertType.notice,
                          content: context.s.please_login_to_use_utility);
                    },
            ),
            // //my reviews
            MenuItemWidget(
              icon: Assets.icons.like.svg(),
              content: context.s.my_review,
              onTap: isLoggedIn == true
                  ? () {
                      context.router.push(const MyRatingRoute());
                    }
                  : () {
                      AppDialogs.show(
                          type: AlertType.notice,
                          content: context.s.please_login_to_use_utility);
                    },
            ),
            // //following shops
            // MenuItemWidget(
            //   icon: Assets.icons.favouriteShop.svg(),
            //   content: context.s.following_shop,
            //   onTap: () {
            //     
            //   },
            // ),
          ]),
    );
  }
}
