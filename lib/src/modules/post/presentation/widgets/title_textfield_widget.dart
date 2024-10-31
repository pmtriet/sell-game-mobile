import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/letter_limit_formatter.dart';
import '../../../../common/formatter/trim_text_formatter.dart';

class TitleTextfieldWidget extends StatelessWidget {
  const TitleTextfieldWidget({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;

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
                  inputFormatters: [
                    TrimmedLeftTextFormatter(),
                    LetterLimitFormatter(AppConstants.maxLengthPostTitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
