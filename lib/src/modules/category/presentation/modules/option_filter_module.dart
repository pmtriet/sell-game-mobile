import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';

class OptionFilterModule extends StatelessWidget {
  const OptionFilterModule({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.w,
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : ColorName.primary,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(color: ColorName.primary),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Text(
              label,
              style: isSelected
                  ? context.textTheme.caption.copyWith(fontSize: 12)
                  : context.textTheme.titleMedium.copyWith(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
