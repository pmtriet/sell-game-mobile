import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: context.router.maybePop,
              child: const Icon(
                Icons.arrow_back,
                color: ColorName.primary,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              title,
              style: context.textTheme.headlineSmall,
            ),
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorName.background,
          ),
          backgroundColor: ColorName.background,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: UIConstants.padding),
            child: body,
          ),
        ),
      ),
    );
  }
}
