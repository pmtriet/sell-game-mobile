import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';

class PostButtonWidget extends StatelessWidget {
  const PostButtonWidget(
      {super.key,
      required this.enable,
      required this.title,
      required this.onTap,
      this.icon});
  final bool enable;
  final String title;
  final VoidCallback onTap;
  final SvgPicture? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: enable ? ColorName.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(
            color: ColorName.primary,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(
                width: 8.w,
              ),
            ],
            Text(
              title,
              style: enable
                  ? context.textTheme.headlineSmall
                  : context.textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
