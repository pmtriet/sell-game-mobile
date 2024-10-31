part of '../page/my_rating_page.dart';

class RatedProductWidget extends StatefulWidget {
  const RatedProductWidget({super.key, required this.order});
  final RatedModel order;

  @override
  State<RatedProductWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RatedProductWidget> {
  bool isExpanded = false;

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
                      child: widget.order.recipent.avatar.filePath.isNotEmpty
                          ? CacheImageWidget(
                              url: widget.order.recipent.avatar.filePath,
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
                            widget.order.recipent.fullname,
                            style: context.textTheme.headlineSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          //datetime
                          Text(
                            widget.order.createdAt.toDateTimeFormat(),
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
                          starNumber: widget.order.star,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //review content
              widget.order.content.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: (isExpanded)
                          ? Text(
                              widget.order.content,
                              style: context.textTheme.headlineSmall,
                            )
                          : Text(
                              widget.order.content,
                              style: context.textTheme.headlineSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                    )
                  : const SizedBox(
                      height: 16,
                    ),
              //order
              OrderWidget(
                code: widget.order.product.code,
                images: widget.order.product.images,
                title: widget.order.product.title,
              ),
              //show viewmore/shortcut when content longer than 2 lines
              if (TextPainterUtils.isTextOverflowing(
                  widget.order.content,
                  context.textTheme.headlineSmall,
                  MediaQuery.of(context).size.width - 3 * UIConstants.padding,
                  2))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          !isExpanded
                              ? context.s.view_more
                              : context.s.shortcut,
                          style: context.textTheme.contentSmall
                              .copyWith(color: ColorName.greyD2D2D2),
                        ),
                        Icon(
                          (!isExpanded)
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          color: ColorName.greyD2D2D2,
                        )
                      ],
                    ),
                  ),
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
// class RatedProductWidget extends StatelessWidget {
//   const RatedProductWidget({super.key, required this.order});
//   final RatedModel order;

//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
