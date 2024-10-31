import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/money_formatter.dart';
import '../../../../common/formatter/only_digit_formatter.dart';
import '../../../../common/formatter/upper_case_formatter.dart';

class WithdrawTextFieldWidget extends StatelessWidget {
  const WithdrawTextFieldWidget({
    super.key,
    required this.controller,
    this.isNumberEditting,
    this.hintText,
    this.suffixWidget,
    this.isMonneyFormatted,
    required this.textInputAction, this.enableUpperCase, this.maxLength,
  });
  final TextEditingController controller;
  final bool? isNumberEditting;
  final String? hintText;
  final Widget? suffixWidget;
  final bool? isMonneyFormatted;
  final TextInputAction textInputAction;
  final bool? enableUpperCase;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: TextField(
        controller: controller,
        style: context.textTheme.headlineSmall,
        textInputAction: textInputAction,
        maxLength: maxLength,
        buildCounter: (context,
            {required int currentLength,
            required bool isFocused,
            required int? maxLength}) {
          return null;
        },
        keyboardType: isNumberEditting != null ? TextInputType.number : null,
        inputFormatters: [
          if (isNumberEditting == true) FilteringTextInputFormatter.digitsOnly,
          if (isNumberEditting == true) OnlyDigitsFormatter(),
          if (isMonneyFormatted == true) MoneyFormatter(),

          if(enableUpperCase != null) UpperCaseTextFormatter(),
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.textTheme.displaySmall,
          suffixIcon: suffixWidget,
          filled: true,
          fillColor: ColorName.background,
          contentPadding: const EdgeInsets.all(16),
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
