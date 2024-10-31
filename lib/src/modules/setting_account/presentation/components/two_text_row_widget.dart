part of '../pages/setting_account_page.dart';

class TwoTextRowWidget extends StatelessWidget {
  const TwoTextRowWidget(
      {super.key,
      required this.onPressedForgotPassword,
      required this.onPressedSaveChanges});
  final VoidCallback onPressedForgotPassword;
  final VoidCallback onPressedSaveChanges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //text Forgot password
          GestureDetector(
            onTap: () {
              onPressedSaveChanges();
            },
            child: Text(
              context.s.save_change,
              style: context.textTheme.captionSmall
                  .copyWith(color: ColorName.primary),
            ),
          ),
        ],
      ),
    );
  }
}
