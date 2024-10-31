import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';

class SummaryItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final int? index;

  const SummaryItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstItem = index == 0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? context.textTheme.captionSmall.copyWith(
                    fontSize: 16,
                  )
                : context.textTheme.captionSmall,
          ),
          Text(
            value,
            style: isTotal
                ? context.textTheme.displayLarge
                : context.textTheme.bodyMedium.copyWith(
                    color:
                        isFirstItem ? ColorName.primary : ColorName.grey8E8E8E),
          ),
        ],
      ),
    );
  }
}
