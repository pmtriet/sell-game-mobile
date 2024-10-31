import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';

class AccountGameTextFieldWidget extends StatefulWidget {
  const AccountGameTextFieldWidget(
      {super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;

  @override
  State<AccountGameTextFieldWidget> createState() =>
      _AccountGameTextFieldWidgetState();
}

class _AccountGameTextFieldWidgetState
    extends State<AccountGameTextFieldWidget> {
  bool _isVisible = false;

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
          padding: const EdgeInsets.only(
            left: UIConstants.padding,
          ),
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
                        text: widget.title,
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
                child: TextField(
                  obscureText: !_isVisible,
                  controller: widget.controller,
                  style: context.textTheme.captionSmall,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        _isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: ColorName.whiteF1F1F1,
                      ),
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
