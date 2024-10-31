part of '../page/shop_profile_page.dart';

//avatar, cover img, name, followings, followers
class ShopInforWidget extends StatelessWidget {
  const ShopInforWidget({super.key, required this.shop});
  final ShopAccountModel shop;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.w),
      child: SizedBox(
        height: 176.w,
        width: 390.w,
        child: Stack(
          children: [
            //cover img and background of infor widget
            Column(
              children: [
                //cover img
                SizedBox(
                  height: 120.w,
                  child: shop.background.filePath.isNotEmpty
                      ? CacheImageWidget(
                          url: shop.background.filePath,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: ColorName.grey353535,
                        ),
                ),
                Container(
                  height: 51,
                  color: ColorName.background,
                )
              ],
            ),
            //infor widget (avatar, name, followings, followers)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: UIConstants.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //avatar
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: shop.avatar.filePath.isNotEmpty
                              ? CacheImageWidget(
                                  url: shop.avatar.filePath,
                                  fit: BoxFit.cover,
                                )
                              : Assets.images.defaultUserAvatar.image(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //name
                          Text(
                            shop.fullname,
                            style: context.textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          //followings, followers
                          // Wrap(
                          //   children: [
                          //     //followers
                          //     Text.rich(
                          //       TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             text: context.s.follower,
                          //             style: context.textTheme.bodyMedium,
                          //           ),
                          //           TextSpan(
                          //             text: shop.follower.length.toString(),
                          //             style: context.textTheme.headlineSmall,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 16.w,
                          //     ),
                          //     //following
                          //     Text.rich(
                          //       TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             text: context.s.following,
                          //             style: context.textTheme.bodyMedium,
                          //           ),
                          //           TextSpan(
                          //             text: shop.following.length.toString(),
                          //             style: context.textTheme.headlineSmall,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
