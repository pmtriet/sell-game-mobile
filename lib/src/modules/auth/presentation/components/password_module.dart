import 'package:flutter/material.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/theme/text_theme/default_text_theme.dart';
import '../../../../common/utils/getit_utils.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget(
      {super.key,
      required TextEditingController passwordTextEditingController,
      required String? errorText,
      required String hintText,
      required this.onFocus})
      : _passwordTextEditingController = passwordTextEditingController,
        _errorText = errorText,
        _hintText = hintText;

  final TextEditingController _passwordTextEditingController;
  final String? _errorText;
  final String _hintText;
  final VoidCallback onFocus;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _passwordVisible = false;

  final FocusNode _focusNode = FocusNode();

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      if (widget._errorText != null) {
        widget.onFocus();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        focusNode: _focusNode,
        obscureText: !_passwordVisible,
        textInputAction: TextInputAction.done,
        controller: widget._passwordTextEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: ColorName.greyD2D2D2,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: ColorName.primary,
              width: 1.0,
            ),
          ),
          hintText: widget._hintText,
          hintStyle: getIt<DefaultTextTheme>().captionMedium,
          errorText: widget._errorText,
          errorMaxLines: 2,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: ColorName.whiteF1F1F1,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        style: getIt<DefaultTextTheme>().captionMedium,
      ),
    );
  }
}
