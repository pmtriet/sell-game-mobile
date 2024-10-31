import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/extensions/build_context_x.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget(
      {super.key,
      required this.title,
      required this.figures,
      });
  final String title;
  final String figures;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            figures,
            style: context.textTheme.caption,
          )
        ],
      ),
    );
  }
}
