import 'package:flutter/material.dart';
import '../../../../common/widgets/button_widget.dart';
import 'summary_item_widget.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String totalLabel;
  final String totalValue;
  final String title;

  const ConfirmButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.totalLabel,
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SummaryItemWidget(
          label: totalLabel,
          value: totalValue,
          isTotal: true,
        ),
        // SizedBox(
        //     height: 16.h), // Add some space between the summary and the button
        SizedBox(
          width: double.infinity,
          child: ButtonWidget(title: title, onTextButtonPressed: () {
            onPressed();
          }, ),
        ),
      ],
    );
  }
}
