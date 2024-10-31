part of '../page/shop_profile_page.dart';

class FollowButtonWidget extends StatelessWidget {
  const FollowButtonWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 37.w,
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 14),
                child: Icon(Icons.add, color: ColorName.whiteF1F1F1),
              ),
              Text(
                context.s.follow,
                style: context.textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
