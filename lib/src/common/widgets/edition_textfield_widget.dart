import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/colors.gen.dart';
import '../constants/ui_constants.dart';
import '../extensions/build_context_x.dart';

class EditionTextFieldWidget extends StatelessWidget {
  const EditionTextFieldWidget(
      {super.key,
      required this.controller,
      this.isPhoneEditting,
      this.hintText,
      this.prefixIcon,
      this.suffixText,
      this.suffixButton});
  final TextEditingController controller;
  final bool? isPhoneEditting;
  final String? hintText;
  final Icon? prefixIcon;
  final Widget? suffixText;
  final Widget? suffixButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        style: context.textTheme.headlineSmall,
        keyboardType: isPhoneEditting != null ? TextInputType.number : null,
        inputFormatters: isPhoneEditting != null
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.textTheme.displaySmall,
          prefixIcon: prefixIcon,
          suffixIcon: suffixText ?? (suffixButton),
          filled: true,
          fillColor: ColorName.background,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            borderSide: const BorderSide(
              color: ColorName.grey353535,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            borderSide: const BorderSide(
              color: ColorName.grey353535,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            borderSide: const BorderSide(
              color: ColorName.grey353535,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
