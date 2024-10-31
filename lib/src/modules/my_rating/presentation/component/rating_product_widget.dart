part of '../page/my_rating_page.dart';

class RatingProductWidget extends StatelessWidget {
  const RatingProductWidget({super.key, required this.order});
  final NoRatingModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //row name
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //avatar shop
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: order.product.account.avatar.filePath.isNotEmpty
                          ? CacheImageWidget(
                              url: order.product.account.avatar.filePath,
                              fit: BoxFit.cover,
                            )
                          : Assets.images.defaultUserAvatar.image(),
                    ),
                  ),
                  //shop name
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        order.product.account.fullname,
                        style: context.textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  //review text
                  SizedBox(
                    width: 102,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.push(RatingRoute(
                                id: order.product.id,
                                value: order.value,
                                code: order.product.code,
                                images: order.product.images,
                                title: order.product.title,
                                popRoute: const MyRatingRoute()));
                          },
                          child: Text(
                            context.s.review,
                            style: context.textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //product
              Padding(
                padding: const EdgeInsets.only(top: 16),
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
                        child: order.product.images.isNotEmpty
                            ? order.product.images[0].filePath.isNotEmpty
                                ? CacheImageWidget(
                                    url: order.product.images.first.filePath,
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
                          order.product.title,
                          style: context.textTheme.captionSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //game category
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            order.product.category.name,
                            style: context.textTheme.bodyMedium
                                .copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //price & time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //price
                            Expanded(
                              child: Text(
                                '${order.value.toNumberFormat()} ${context.s.currency_unit}',
                                style: context.textTheme.titleLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            //time
                            Text(order.createdAt.toDateTimeFormat(),
                                style: context.textTheme.bodyMedium
                                    .copyWith(fontSize: 12)),
                          ],
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: ColorName.grey353535,
          thickness: 1,
        )
      ],
    );
  }
}
