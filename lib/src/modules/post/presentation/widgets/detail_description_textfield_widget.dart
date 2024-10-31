import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/letter_limit_formatter.dart';
import '../../../../common/formatter/trim_text_formatter.dart';

class DetailDescriptionTextFieldWidget extends StatefulWidget {
  const DetailDescriptionTextFieldWidget(
      {super.key, required this.controller, required this.maxLength});
  final TextEditingController controller;
  final int maxLength;

  @override
  State<DetailDescriptionTextFieldWidget> createState() =>
      _DetailDescriptionTextFieldWidgetState();
}

class _DetailDescriptionTextFieldWidgetState
    extends State<DetailDescriptionTextFieldWidget> {
  int currentLength = 0;

  late VoidCallback _textFieldListener;

  @override
  void initState() {
    super.initState();

    _textFieldListener = () {
      setState(() {
        currentLength = widget.controller.text.length;
      });
    };

    // Add the listener to the controller
    widget.controller.addListener(_textFieldListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_textFieldListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(color: ColorName.grey353535),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.s.detail_description,
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    '$currentLength/${widget.maxLength}',
                    style: context.textTheme.bodyMedium,
                  )
                ],
              ),
              TextFormField(
                controller: widget.controller,
                maxLength: widget.maxLength,
                maxLines: 5,
                style: context.textTheme.bodyMedium
                    .copyWith(color: ColorName.whiteF1F1F1),
                decoration: const InputDecoration(
                    border: InputBorder.none, counterText: ''),
                inputFormatters: <TextInputFormatter>[
                  LetterLimitFormatter(widget.maxLength),
                  TrimmedTextFormatter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
