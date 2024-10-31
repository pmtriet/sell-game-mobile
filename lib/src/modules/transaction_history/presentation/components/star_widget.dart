import 'package:flutter/material.dart';

import '../../../../../generated/assets.gen.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({super.key, required this.starNumber});
  final int starNumber;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(5, (index) {
        if (index < starNumber) {
          return Assets.icons.starEnable.svg();
        } else {
          return Assets.icons.starDisable.svg(); 
        }
      }),
    );
  }
}