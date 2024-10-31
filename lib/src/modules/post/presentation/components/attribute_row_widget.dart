import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/trim_text_formatter.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';

class AttributeRowWidget extends StatelessWidget {
  const AttributeRowWidget(
      {super.key,
      required this.attribute,
      required this.onValueChanged,
      required this.onDeleteAttribute});
  final CategoryAttributeModel attribute;
  final Function(String) onValueChanged;
  final VoidCallback onDeleteAttribute;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: attribute.value);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(color: ColorName.grey353535),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160.w,
                child: Text(
                  attribute.title,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Container(
                height: 30,
                width: 1,
                color: ColorName.grey8E8E8E,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    onValueChanged(value);
                  },
                  style: context.textTheme.bodyMedium
                      .copyWith(color: ColorName.whiteF1F1F1),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    TrimmedTextFormatter(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onDeleteAttribute,
                child: const Icon(
                  Icons.clear,
                  color: ColorName.grey8E8E8E,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
