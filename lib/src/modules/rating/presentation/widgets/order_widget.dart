part of '../page/rating_page.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.value,
    required this.code,
    required this.images,
    required this.title,
  });
  final int value;
  final String code;
  final List<ProductImageModel> images;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorName.black1E1E1E,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.itemRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image
            Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UIConstants.imgRadius)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(UIConstants.imgRadius),
                child: images.isNotEmpty
                    ? images[0].filePath.isNotEmpty
                        ? CacheImageWidget(
                            url: images[0].filePath,
                            fit: BoxFit.cover,
                          )
                        : Assets.icons.deletedImage.svg()
                    : Assets.icons.deletedImage.svg(),
              ),
            ),

            //content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      title,
                      style: context.textTheme.contentSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // ID text
                    Text(
                      'ID: $code',
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                    // Price text
                    Text(
                      '${value.toNumberFormat()} ${context.s.currency_unit}',
                      style: context.textTheme.headingSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
