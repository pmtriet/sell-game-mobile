import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/fonts.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/cache_image_widget.dart';

class ProductSummaryWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String gameName;
  final String code;
  final String price;
  final String? priceBeforeSale;
  final double? discount;

  const ProductSummaryWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.gameName,
    required this.code,
    required this.price,
    this.priceBeforeSale,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 86.w,
          height: 86.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: const Border(
              top: BorderSide(width: 1.5, color: ColorName.grey353535),
              left: BorderSide(width: 1.5, color: ColorName.grey353535),
              right: BorderSide(width: 1.5, color: ColorName.grey353535),
              bottom: BorderSide(width: 1.5, color: ColorName.grey353535),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CacheImageWidget(
              url: imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ), // Adjust image size
        SizedBox(width: 16.w),
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.captionSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: gameName,
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  );
                  textPainter.layout(maxWidth: constraints.maxWidth - 75.w);

                  bool isOverflow = textPainter.didExceedMaxLines;

                  return Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  gameName,
                                  style: context.textTheme.contentSmall
                                      .copyWith(color: ColorName.grey8E8E8E),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (!isOverflow) ...[
                                SizedBox(width: 8.w),
                                Assets.icons.ellipse
                                    .svg(width: 4.w, height: 4.h),
                                SizedBox(width: 8.w),
                                Text(
                                  'ID: $code',
                                  style: context.textTheme.contentSmall
                                      .copyWith(color: ColorName.grey8E8E8E),
                                ),
                              ],
                            ],
                          ),
                          if (isOverflow) ...[
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Assets.icons.ellipse
                                    .svg(width: 4.w, height: 4.h),
                                SizedBox(width: 8.w),
                                Text(
                                  'ID: $code',
                                  style: context.textTheme.contentSmall
                                      .copyWith(color: ColorName.grey8E8E8E),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    price,
                    style: context.textTheme.caption.copyWith(fontSize: 16),
                  ),
                  if (discount != null && (discount! * 100).toInt() != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorName.grey353535,
                            borderRadius:
                                BorderRadius.circular(UIConstants.imgRadius)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            ' -${(discount! * 100).toInt()}% ',
                            style: context.textTheme.headingSmall
                                .copyWith(fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  if (priceBeforeSale != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        priceBeforeSale!,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: ColorName.grey8E8E8E,
                          color: ColorName.grey8E8E8E,
                          fontSize: 12,
                          fontFamily: FontFamily.roboto,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
