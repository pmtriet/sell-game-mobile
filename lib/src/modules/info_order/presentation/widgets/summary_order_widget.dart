import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'summary_order_item_widget.dart';

class SummaryOrderWidget extends StatelessWidget {
  final List<Map<String, String>> summaryItems;
  final int? highlightIndex;

  const SummaryOrderWidget({
    super.key,
    required this.summaryItems,
    this.highlightIndex,
  });
@override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...summaryItems.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> item = entry.value;

          return Column(
            children: [
              SummaryOrderItemWidget(
                label: item['label']!,
                value: item['value']!,
                isTotal: index == highlightIndex, 
              ),
              if (index >= 1) SizedBox(height: 16.h), 
            ],
          );
        }),
      ],
    );
  }
}


