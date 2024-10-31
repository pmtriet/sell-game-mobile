part of '../page/my_rating_page.dart';

class BuyerRatedWidget extends StatelessWidget {
  const BuyerRatedWidget({super.key, required this.order});
  final BuyerRatingModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //avatar, name, starNumber
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //avatar shop
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: order.account.avatar.filePath.isNotEmpty
                          ? CacheImageWidget(
                              url: order.account.avatar.filePath,
                              fit: BoxFit.cover,
                            )
                          : Assets.images.defaultUserAvatar.image(),
                    ),
                  ),
                  //shop name, time
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //shop name
                          Text(
                            order.account.fullname,
                            style: context.textTheme.headlineSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          //datetime
                          Text(
                            order.createdAt.toDateTimeFormat(),
                            style: context.textTheme.headlineSmall
                                .copyWith(color: ColorName.grey8E8E8E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //review star
                  SizedBox(
                    width: 102,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StarWidget(
                          starNumber: order.star,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //review content
              order.content.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        order.content,
                        style: context.textTheme.headlineSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : const SizedBox(
                      height: 16,
                    ),
              //order
              OrderWidget(
                code: order.product.code,
                images: order.product.images,
                title: order.product.title,
              )
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
