import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/colors.gen.dart';
import '../extensions/build_context_x.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget(
      {super.key,
      required this.icon,
      required this.content,
      required this.onTap,
      this.disableColor});
  final SvgPicture icon;
  final String content;
  final VoidCallback onTap;
  final bool? disableColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 48.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon
            Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46),
                color: disableColor == null
                    ? ColorName.primary
                    : ColorName.grey8E8E8E,
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            //content
            Expanded(
              child: Text(
                content,
                style: context.textTheme.contentMedium,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
