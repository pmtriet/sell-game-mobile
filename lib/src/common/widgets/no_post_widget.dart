import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/colors.gen.dart';
import '../extensions/build_context_x.dart';

class NoPostWidget extends StatelessWidget {
  const NoPostWidget({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Assets.icons.noPost.svg(),
        ),
        Text(
          content,
          style: context.textTheme.contentMedium
              .copyWith(color: ColorName.grey353535),
        )
      ],
    );
  }
}
