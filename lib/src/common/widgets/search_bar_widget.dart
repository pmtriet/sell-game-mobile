import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/colors.gen.dart';
import '../constants/ui_constants.dart';
import '../theme/text_theme/default_text_theme.dart';
import '../utils/getit_utils.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.hintText,
    this.onSearch,
    this.onChanged,
    this.onSubmitted,
    this.width = 358,
    this.controller,
    this.focusNode,
  });

  final String hintText;
  final VoidCallback? onSearch;
  final ValueChanged<String>? onChanged;
  final double width;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Container(
        width: widget.width.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: ColorName.black1E1E1E,
          borderRadius: BorderRadius.circular(UIConstants.imgRadius),
          border: Border.all(color: ColorName.grey353535),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: TextField(
            focusNode: widget.focusNode,
            onTap: widget.onSearch,
            onChanged: (value) {
              if (_controller.text.isNotEmpty || value.isEmpty) {
                setState(() {});
              }
              // setState((){});
              widget.onChanged?.call(value);
            },
            onSubmitted: widget.onSubmitted,
            controller: _controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: ColorName.primary,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        _controller.clear();
                        // if (widget.onChanged != null) {
                        //   widget.onChanged!('');
                        // }
                        widget.onChanged?.call('');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Assets.icons.close.svg(),
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: getIt<DefaultTextTheme>().displaySmall,
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
