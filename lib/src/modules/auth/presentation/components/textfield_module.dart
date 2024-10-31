import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.textEditingController,
      this.errorText,
      required this.hintText, required this.onFocus,
      });
  final TextEditingController textEditingController;
  final String? errorText;
  final String hintText;
  final VoidCallback onFocus;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final FocusNode _focusNode = FocusNode();

   void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      if (widget.errorText != null) {
        widget.onFocus();
      }
    }
  }

  @override
  void initState() {
    super.initState();
     _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
     _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.textEditingController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: ColorName.greyD2D2D2,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: ColorName.primary,
              width: 1.0,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: context.textTheme.captionMedium,
          errorText: widget.errorText,
          errorMaxLines: 2,
        ),
        style: context.textTheme.captionMedium,
      ),
    );
  }
}
