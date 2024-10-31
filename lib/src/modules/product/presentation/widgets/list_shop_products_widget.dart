part of '../pages/product_page.dart';

class ListShopProductsWidget extends StatelessWidget {
  const ListShopProductsWidget(
      {super.key,
      required this.shopProducts,
      required this.shopId,
      required this.shopName,
      required this.onLoading,
      required this.unLoading});
  final SuggestProductModel shopProducts;
  final int shopId;
  final String shopName;
  final VoidCallback onLoading;
  final VoidCallback unLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          //title, next button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //title
              Text(
                context.s.other_shop_posts.toUpperCase(),
                style: context.textTheme.titleSmall,
              ),
              //next button
              GestureDetector(
                  onTap: () {
                    context.router.push(
                        ShopProfileRoute(shopName: shopName, shopId: shopId));
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: ColorName.whiteF1F1F1,
                  ))
            ],
          ),
          //line
          Padding(
            padding: EdgeInsets.only(bottom: 10.w),
            child: const Divider(
              color: ColorName.grey353535,
              thickness: 1,
            ),
          ),
          //list products
          SizedBox(
            height: 234.w,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shopProducts.data.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.push(ProductRoute(
                              productId: shopProducts.data[index].id));
                        },
                        child: ProductCardWidget(
                          product: shopProducts.data[index],
                          onLoading: () => onLoading(),
                          unLoading: () => unLoading(),
                        ),
                      ),
                      if (index < shopProducts.data.length - 1)
                        const SizedBox(width: 16),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
