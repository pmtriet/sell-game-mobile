import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';


class BalanceWidget extends StatelessWidget {
  final String label;
  final String balance;
  final String? svgIconPath;  // Path to the SVG icon file
  final VoidCallback? onIconPressed;

  const BalanceWidget({
    super.key,
    required this.label,
    required this.balance,
    this.svgIconPath,  // SVG icon path, optional
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.textTheme.captionSmall,
            ),
            Row(
              children: [
                Text(
                  balance,
                  style: context.textTheme.labelMedium,
                ),
                if (svgIconPath != null) ...[
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: onIconPressed,
                    child: SvgPicture.asset(
                      svgIconPath!,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        const Divider(color: ColorName.grey353535, height: 1.5),
      ],
    );
  }
}
