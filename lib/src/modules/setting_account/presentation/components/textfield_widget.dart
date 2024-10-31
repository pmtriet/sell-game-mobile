part of '../pages/setting_account_page.dart';
class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.forcusNode,
      required this.nextFocusNode});
  final TextEditingController textEditingController;
  final String hintText;
  final FocusNode forcusNode;
  final FocusNode nextFocusNode;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.forcusNode.addListener(_updateSuffixIcon);
  }

  @override
  void dispose() {
    widget.forcusNode.removeListener(_updateSuffixIcon);
    super.dispose();
  }

  void _updateSuffixIcon() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: TextField(
        controller: widget.textEditingController,
        textInputAction: TextInputAction.next,
        obscureText: !_passwordVisible,
        focusNode: widget.forcusNode,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        },
        decoration: InputDecoration(
          suffixIcon: widget.forcusNode.hasFocus
              ? IconButton(
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
                )
              : null,
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
          hintText: widget.hintText,
          hintStyle: context.textTheme.captionMedium,
        ),
        style: context.textTheme.captionMedium,
      ),
    );
  }
}
