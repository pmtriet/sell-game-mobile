import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';

class EditionPage extends StatelessWidget {
  const EditionPage({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: context.router.maybePop,
                icon: const Icon(
                  Icons.arrow_back,
                  color: ColorName.primary,
                )),
            titleSpacing: 0,
            title: Text(
              title.toUpperCase(),
              style: context.textTheme.contentMedium,
            ),
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorName.background,
          ),
          backgroundColor: ColorName.background,
          body: body,
        ),
      ),
    );
  }
}
