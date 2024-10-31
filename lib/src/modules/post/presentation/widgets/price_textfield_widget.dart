import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/money_formatter.dart';
import '../../../../common/formatter/only_digit_formatter.dart';

class PriceTextfieldWidget extends StatelessWidget {
  const PriceTextfieldWidget(
      {super.key,
      required this.title,
      required this.suffixText,
      this.maxLength,
      required this.controller});
  final String title;
  final String suffixText;
  final TextEditingController controller;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(color: ColorName.grey353535),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 85.w,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: context.textTheme.bodyMedium.copyWith(),
                      ),
                      TextSpan(
                        text: ' ${context.s.necessary_symbol}',
                        style: context.textTheme.bodyMedium
                            .copyWith(color: ColorName.primary),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  style: context.textTheme.captionSmall,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLength: maxLength,
                  buildCounter: maxLength != null
                      ? (context,
                          {required int currentLength,
                          required bool isFocused,
                          required int? maxLength}) {
                          return null;
                        }
                      : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    OnlyDigitsFormatter(),
                    MoneyFormatter(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  suffixText,
                  style: context.textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
