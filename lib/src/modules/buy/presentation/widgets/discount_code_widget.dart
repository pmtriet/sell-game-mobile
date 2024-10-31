import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/upper_case_formatter.dart';

class DiscountCodeWidget extends StatefulWidget {
  final String hintText;
  final String buttonText;
  final String? svgIconPath; // Path to the SVG icon
  final Function(String) onApplyPressed;
  final Function? onClearPressed;

  const DiscountCodeWidget({
    super.key,
    required this.hintText,
    required this.buttonText,
    this.svgIconPath,
    required this.onApplyPressed,
    this.onClearPressed,
  });

  @override
  State<DiscountCodeWidget> createState() => _DiscountCodeWidgetState();
}

class _DiscountCodeWidgetState extends State<DiscountCodeWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearIcon = _controller.text.isNotEmpty;
      });
    });
  }

  void _clearCode() {
    _controller.clear();
    setState(() {
      _showClearIcon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: SizedBox(
            height: 40.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              decoration: BoxDecoration(
                color: ColorName.background,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorName.grey353535, width: 1.5.w),
              ),
              child: Row(
                children: [
                  if (widget.svgIconPath != null) ...[
                    SvgPicture.asset(
                      widget.svgIconPath!,
                      width: 20.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Flexible(
                    fit: FlexFit.loose,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: context.textTheme.captionSmall
                            .copyWith(color: ColorName.grey626262),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 0,
                        ),
                        suffixIcon: _showClearIcon
                            ? GestureDetector(
                                onTap: () {
                                  _clearCode();
                                  if (widget.onClearPressed != null) {
                                    widget.onClearPressed!();
                                  }
                                },
                                child: SvgPicture.asset(
                                  Assets.icons.close.path,
                                  // width: 0.005.w,
                                  // height: 0.005.h,
                                ),
                              )
                            : null,
                      ),
                      style: context.textTheme.captionSmall,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        SizedBox(
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.onApplyPressed(_controller.text.trim());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorName.primary,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              widget.buttonText,
              style: context.textTheme.captionSmall,
            ),
          ),
        ),
      ],
    );
  }
}
