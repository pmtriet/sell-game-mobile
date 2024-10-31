import 'package:flutter/material.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import 'summary_item_widget.dart';

class SummaryWidget extends StatelessWidget {
  final List<Map<String, String>> summaryItems;
  final String? voucherCode;

  const SummaryWidget({
    super.key,
    required this.summaryItems,
    this.voucherCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...summaryItems.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> item = entry.value;

          
          if (index == 1 && voucherCode != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      item['label']!,
                      style: context.textTheme.regular.copyWith(
                        color: ColorName.whiteF1F1F1,
                        fontSize: 14,
                      ), // White label
                    ),
                    const SizedBox(width: 8), 
                    Container(
                      height: 16,
                      width: 1,
                      color: ColorName.grey353535,
                    ),
                    const SizedBox(width: 8),
                    Text(voucherCode!.length > 11 ? '${voucherCode!.substring(0, 11)}...' : voucherCode!,
                        style: context.textTheme.regular.copyWith(
                          color: ColorName.primary,
                          fontSize: 14,
                        ) // Green voucher code
                        ),
                  ],
                ),
                Text(
                  item['value']!,
                  style: context.textTheme.regular.copyWith(
                    color: ColorName.whiteF1F1F1,
                    fontSize: 14,
                  ),
                ),
              ],
            );
          }

          return SummaryItemWidget(
            label: item['label']!,
            value: item['value']!,
            index: index,
          );
        }),
      ],
    );
  }
}
