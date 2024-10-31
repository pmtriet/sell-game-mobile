part of '../pages/setting_account_page.dart';

class RowWidget extends StatelessWidget {
  const RowWidget(
      {super.key,
      required this.title,
      this.enable,
      this.onTap,
      this.suffixIcon});
  final String title;
  final bool? enable;
  final VoidCallback? onTap;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          height: 48.w,
          color: ColorName.black1E1E1E,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: UIConstants.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: context.textTheme.captionSmall
                      .copyWith(color: ColorName.greyBBBBBB),
                ),
                if (enable != null)
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Icon(
                      suffixIcon,
                      size: 25.w,
                      color: ColorName.greyBBBBBB,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
