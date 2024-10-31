part of '../pages/product_page.dart';

class ShopInforWidget extends StatelessWidget {
  const ShopInforWidget({super.key, required this.shop});
  final ShopAccountModel shop;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 156.w,
      color: ColorName.black1E1E1E,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //avatar, name, view shop button
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //avatar
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              width: 48.w,
                              height: 48.w,
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
                          //shop name
                          Expanded(
                            child: Text(
                              shop.fullname,
                              style: context.textTheme.captionSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //view shop button
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: OutlinedButton(
                      onPressed: () {
                        context.router.push(ShopProfileRoute(
                            shopName: shop.fullname, shopId: shop.id));
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorName.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(UIConstants.itemRadius),
                        ),
                        foregroundColor: ColorName.primary,
                      ),
                      child: Text(
                        context.s.view_shop,
                        style: context.textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ShopStatsWidget(
              argReview: shop.avgRating,
              soldNumber: shop.count.transactions,
              sellingNumber: shop.count.products,
              createdAt: shop.createdAt,
            ),
          ],
        ),
      ),
    );
  }
}
