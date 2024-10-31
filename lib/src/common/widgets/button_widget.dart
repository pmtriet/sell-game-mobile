import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/colors.gen.dart';
import '../constants/ui_constants.dart';
import '../extensions/build_context_x.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.onTextButtonPressed,
    this.icon, // Optional SvgPicture parameter
    this.foregroundColor = Colors.white,
    this.backgroundColor = ColorName.primary,
    this.borderSideColor = Colors.transparent,
    this.titleColor,
    this.isDisable,
  });

  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderSideColor;
  final Color? titleColor;
  final String title;
  final VoidCallback? onTextButtonPressed;
  final SvgPicture? icon; // Icon parameter for SVG, can be null
  final bool? isDisable;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: widget.onTextButtonPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: widget.foregroundColor,
                backgroundColor: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                  side: BorderSide(
                    color: widget.borderSideColor,
                    width: 1.w,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      widget.icon!, // Display the provided SvgPicture
                      SizedBox(
                        width: 8.w,
                      ),
                    ],
                    Text(
                      widget.title,
                      style: context.textTheme.bodyLarge
                          .copyWith(color: widget.titleColor, fontSize: 15),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isDisable != null && widget.isDisable == true)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
