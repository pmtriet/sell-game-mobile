part of '../page/marketplace_page.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget(
      {super.key,
      required this.shop,
      required this.onTapToViewMoreButton,
      required this.onTapToProduct,
      required this.onLoading,
      required this.unLoading});
  final MarketplaceProductFollowShopModel shop;
  final Function() onTapToViewMoreButton;
  final Function(int productId) onTapToProduct;
  final VoidCallback onLoading;
  final VoidCallback unLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //shop name row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //shop name
            Expanded(
              child: Text(
                shop.account.name,
                style: context.textTheme.bodyLarge.copyWith(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //view more
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () => onTapToViewMoreButton(),
                child: Row(
                  children: [
                    Text(
                      context.s.view_more,
                      style: context.textTheme.titleSmall,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: ColorName.greyBBBBBB,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: Container(
            height: 2,
            width: double.infinity,
            color: ColorName.grey353535,
          ),
        ),
        //gridview products
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 173 / 233,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.w,
            ),
            itemCount: shop.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTapToProduct(shop.data[index].id),
                child: ProductCardWidget(
                  product: shop.data[index],
                  onLoading: () => onLoading(),
                  unLoading: () => unLoading(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
