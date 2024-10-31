import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/date_time_x.dart';

class TimeOrderWidget extends StatelessWidget {
  final String orderCode;
  final DateTime orderTime; 

  const TimeOrderWidget({
    super.key,
    required this.orderCode,
    required this.orderTime,
  });

  @override
  Widget build(BuildContext context) {
    
    final String formattedTime = orderTime.format(DateFormatType.hhmmddMMyy);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.s.order_id,
              style: context.textTheme.captionSmall,
            ),
            Row(
              children: [
                Text(
                  '#$orderCode',
                  style: context.textTheme.labelLarge.copyWith(color: ColorName.whiteF1F1F1),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: orderCode));
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.s.copied),
                      ),
                    );
                    
                  },
                  child: Text(
                    context.s.copy,
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.s.order_time,
              style: context.textTheme.captionSmall.copyWith(color: ColorName.grey8E8E8E),
            ),
            Text(
              formattedTime, 
              style: context.textTheme.captionSmall.copyWith(color: ColorName.grey8E8E8E),
            ),
          ],
        ),
      ],
    );
  }
}
