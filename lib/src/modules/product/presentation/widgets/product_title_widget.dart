part of '../pages/product_page.dart';

class ProductTitleWidget extends StatelessWidget {
  final String title;
  final String gameName;
  final String? id;
  final String? timeAgo;

  const ProductTitleWidget({
    super.key,
    required this.title,
    required this.gameName,
    required this.id,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.contentSmall.copyWith(fontSize: 15.sp),
        ),
        SizedBox(height: 8.h),
        Wrap(
          children: _buildDetailsItems(context),
        ),
      ],
    );
  }

  List<Widget> _buildDetailsItems(BuildContext context) {
    return [
      id != null
          ? Wrap(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      gameName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                    SizedBox(width: 8.w),
                    Assets.icons.ellipse.svg(width: 4.w, height: 4.h),
                    SizedBox(width: 8.w),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ID: $id',
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                    SizedBox(width: 8.w), // Spacer between items
                    Assets.icons.ellipse.svg(width: 4.w, height: 4.h),
                    SizedBox(width: 8.w),
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
      timeAgo != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.icons.clock.svg(width: 12.w, height: 12.h),
                SizedBox(width: 4.w),
                Text(
                  timeAgo!,
                  style: context.textTheme.contentSmall
                      .copyWith(color: ColorName.grey8E8E8E),
                ),
              ],
            )
          : const SizedBox.shrink(),
    ];
  }
}
