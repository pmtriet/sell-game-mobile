import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';

class TextSpanWidget extends StatelessWidget {
  const TextSpanWidget({
    super.key,
    required enableTextSpan,
    required disableTextSpan,
    required onTextSpanTap,
  })  : _enableTextSpan = enableTextSpan,
        _disableTextSpan = disableTextSpan,
        _onTextSpanTap = onTextSpanTap;

  final String _disableTextSpan;
  final String _enableTextSpan;
  final VoidCallback _onTextSpanTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: _disableTextSpan,
              style: context.textTheme.bodyMedium,
            ),
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: _onTextSpanTap,
                  child: Text(
                    _enableTextSpan,
                    style: context.textTheme.bodyMedium
                        .copyWith(color: ColorName.primary),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
