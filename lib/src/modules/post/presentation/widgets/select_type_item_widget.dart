import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../components/attribute_row_widget.dart';

class SelectTypeItemWidget extends StatefulWidget {
  const SelectTypeItemWidget(
      {super.key,
      required this.attributes,
      required this.onAttributeValueChanged,
      required this.onChange,
      required this.onDeleteAttribute});
  final Map<CategoryAttributeModel, bool> attributes;
  final Function(CategoryAttributeModel, String) onAttributeValueChanged;
  final Function(CategoryAttributeModel) onChange;
  final Function(CategoryAttributeModel) onDeleteAttribute;

  @override
  State<SelectTypeItemWidget> createState() => _SelectTypeItemWidgetState();
}

class _SelectTypeItemWidgetState extends State<SelectTypeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: DropdownButtonFormField2<CategoryAttributeModel>(
            key: UniqueKey(),
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                borderSide: const BorderSide(color: ColorName.grey353535),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                borderSide: const BorderSide(color: ColorName.grey353535),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                borderSide: const BorderSide(color: ColorName.grey353535),
              ),
            ),
            hint: Text(
              context.s.select_item_type,
              style: context.textTheme.bodyMedium,
            ),
            style: context.textTheme.bodyMedium,
            items: widget.attributes.entries
                .map((item) => DropdownMenuItem<CategoryAttributeModel>(
                      value: item.key,
                      child: Text(
                        item.key.title,
                        style: context.textTheme.bodyMedium
                            .copyWith(color: ColorName.whiteF1F1F1),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select game';
              }
              return null;
            },
            onChanged: (value) {
              if (value != null) {
                widget.onChange(value);
              }
            },
            // value: null,
            selectedItemBuilder: (BuildContext context) {
              return widget.attributes.entries.map((item) {
                return Text(
                  context.s.select_item_type,
                  style: context.textTheme.bodyMedium,
                );
              }).toList();
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: ColorName.primary,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorName.grey353535,
              ),
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16)),
          ),
        ),
        //List attributes selected
        Column(
          children: widget.attributes.entries
              .where((item) => item.value == true)
              .map((item) => AttributeRowWidget(
                    attribute: item.key,
                    onValueChanged: (newValue) {
                      widget.onAttributeValueChanged(item.key, newValue);
                    },
                    onDeleteAttribute: () => widget.onDeleteAttribute(item.key),
                  ))
              .toList(),
        )
      ],
    );
  }
}
