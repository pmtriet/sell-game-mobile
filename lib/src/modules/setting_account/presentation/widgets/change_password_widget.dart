part of '../pages/setting_account_page.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget(
      {super.key,
      required this.currentPasswordController,
      required this.newPasswordController,
      required this.newPasswordAgainController});
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController newPasswordAgainController;

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode newPasswordAgainFocusNode = FocusNode();

  @override
  void dispose() {
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    newPasswordAgainFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //current password textfield
          TextFieldWidget(
            textEditingController: widget.currentPasswordController,
            hintText: context.s.enter_current_password,
            forcusNode: currentPasswordFocusNode,
            nextFocusNode: newPasswordFocusNode,
          ),

          //new password textfield
          TextFieldWidget(
            textEditingController: widget.newPasswordController,
            hintText: context.s.enter_new_password,
            forcusNode: newPasswordFocusNode,
            nextFocusNode: newPasswordAgainFocusNode,
          ),

          //new password textfield again
          TextFieldWidget(
            textEditingController: widget.newPasswordAgainController,
            hintText: context.s.enter_new_password_again,
            forcusNode: newPasswordAgainFocusNode,
            nextFocusNode: FocusNode(),
          ),
        ],
      ),
    );
  }
}
