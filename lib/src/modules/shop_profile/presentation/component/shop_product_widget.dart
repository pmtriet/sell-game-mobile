part of '../page/shop_profile_page.dart';

class ShopProductWidget extends StatelessWidget {
  const ShopProductWidget(
      {super.key, required this.product, required this.onTap});
  final MarketplaceProductModel product;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //order image
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(UIConstants.imgRadius)),
                child: product.images.isNotEmpty
                    ? product.images.first.filePath.isNotEmpty
                        ? CacheImageWidget(
                            url: product.images.first.filePath,
                            fit: BoxFit.cover,
                          )
                        : Assets.icons.deletedImage.svg()
                    : Assets.icons.deletedImage.svg(),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                Text(
                  product.title,
                  style: context.textTheme.captionSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                //game category
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(product.category.name,
                      style:
                          context.textTheme.bodyMedium.copyWith(fontSize: 12)),
                ),
                //price & time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text(
                        '${product.price.toNumberFormat()} ${context.s.currency_unit}',
                        style: context.textTheme.titleLarge),
                    //time
                    Text(product.updatedAt.toDateTimeFormat(),
                        style: context.textTheme.bodyMedium
                            .copyWith(fontSize: 12)),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
