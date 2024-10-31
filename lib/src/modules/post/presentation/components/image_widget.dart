import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.image,
      required this.onDeleteNewImage,
      this.isFirst});
  final File image;
  final VoidCallback onDeleteNewImage;
  final bool? isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 77.w,
          height: 77.w,
          decoration: BoxDecoration(
            color: ColorName.grey353535,
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            border: Border.all(color: ColorName.grey353535),
          ),
          child: Center(
            child: SizedBox(
                height: 50.w,
                width: 77.w,
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Positioned(
          top: 4.w,
          right: 4.w,
          child: GestureDetector(
            onTap: onDeleteNewImage,
            child: const Icon(
              Icons.close,
              size: 18,
              color: ColorName.whiteF1F1F1,
            ),
          ),
        ),
        //gradient background
        if (isFirst != null)
          Positioned.fill(
            top: 40,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    ColorName.green3BD9AC.withOpacity(0.7),
                    Colors.transparent
                  ])),
            ),
          ),
        if (isFirst != null) 
          //text background
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 4),
              child: Text(
                context.s.background_image,
                style: context.textTheme.contentSmall,
              ),
            ),
          ),
      ],
    );
  }
}
