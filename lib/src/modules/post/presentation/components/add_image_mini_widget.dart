import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../common/constants/ui_constants.dart';

class AddImageMiniWidget extends StatelessWidget {
  const AddImageMiniWidget({super.key, required this.onSelect});
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect();
      },
      child: Container(
        width: 77.w,
        height: 77.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          shape: BoxShape.rectangle,
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(UIConstants.itemRadius),
          dashPattern: const [6, 6],
          color: Colors.greenAccent,
          strokeWidth: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Assets.icons.camera.svg(),
            ),
          ),
        ),
      ),
    );
  }
}
