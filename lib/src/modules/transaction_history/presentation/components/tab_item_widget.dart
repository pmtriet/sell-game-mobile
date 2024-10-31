import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
      {super.key,
      required this.label,
      required this.isSelected,
      this.onTap,
      this.number, this.width});
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final int? number;
  final int? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 37.w,
        width: width == null ? 173.w : width!.w,
        decoration: BoxDecoration(
          color: isSelected ? ColorName.grey353535 : ColorName.black1E1E1E,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: isSelected ? Border.all(color: ColorName.grey626262) : null,
        ),
        child: Center(
          child: Text(
            number == null ? label : '$label - $number',
            style: isSelected
                ? context.textTheme.headlineSmall
                : context.textTheme.headlineSmall
                    .copyWith(color: ColorName.greyBBBBBB),
          ),
        ),
      ),
    );
  }
}
