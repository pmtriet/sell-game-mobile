part of '../pages/saved_post_page.dart';

class SavedPostWidget extends StatefulWidget {
  const SavedPostWidget(
      {super.key,
      required this.post,
      required this.deleteSavedPost});
  final SavedPostModel post;
  final Function(int id) deleteSavedPost;

  @override
  State<SavedPostWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SavedPostWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112.w,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.post.images.isNotEmpty
                    ? widget.post.images[0].filePath.isNotEmpty
                        ? CacheImageWidget(
                            url: widget.post.images[0].filePath,
                            fit: BoxFit.cover,
                          )
                        : Assets.icons.deletedImage.svg()
                    : Assets.icons.deletedImage.svg(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: context.textTheme.captionSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.post.category.name,
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.post.currentPrice.toInt().toVND(),
                      style: context.textTheme.caption.copyWith(fontSize: 16),
                    ),
                    IconButton(
                      icon: Assets.icons.star.svg(
                        width: 24.w,
                        height: 24.h,
                      ),
                      onPressed: () => widget.deleteSavedPost(widget.post.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}