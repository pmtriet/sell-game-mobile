part of '../pages/setting_account_page.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onTap, required this.title});
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 24.0, horizontal: UIConstants.padding),
        child: Container(
          height: 48.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorName.grey353535,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          ),
          child: Center(
            child: Text(
              title,
              style: context.textTheme.captionSmall
                  .copyWith(color: ColorName.greyBBBBBB),
            ),
          ),
        ),
      ),
    );
  }
}
