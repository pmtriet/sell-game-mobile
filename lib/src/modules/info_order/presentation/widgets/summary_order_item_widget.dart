import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';

class SummaryOrderItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryOrderItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? context.textTheme.titleLarge
                    .copyWith(color: ColorName.whiteF1F1F1)
                : context.textTheme.captionSmall
                    .copyWith(color: ColorName.grey8E8E8E),
          ),
          Text(
            value,
            style: isTotal
                ? context.textTheme.displayLarge
                : context.textTheme.captionSmall
                    .copyWith(color: ColorName.grey8E8E8E),
          ),
        ],
      ),
    );
  }
}
