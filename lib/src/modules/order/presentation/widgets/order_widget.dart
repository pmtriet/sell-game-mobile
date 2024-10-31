import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/date_time_x.dart';

class OrderWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String gameName;
  final String price;
  final DateTime timeOrder;

  const OrderWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.gameName,
    required this.price,
    required this.timeOrder,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedTimeOrder = timeOrder.format(DateFormatType.hhmmddMMyy);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.padding, vertical: UIConstants.itemRadius),
      child: Row(
        children: [
          Container(
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
              child: Image.asset(
                imagePath,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.fitHeight, // Adjust image size
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(
                  title,
                  style: context.textTheme.captionSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      gameName,
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.s.price,
                      style: context.textTheme.caption.copyWith(fontSize: 16),
                    ),
                    Text(
                      formattedTimeOrder.toString(),
                      style: context.textTheme.captionMedium
                          .copyWith(color: ColorName.grey8E8E8E),
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
