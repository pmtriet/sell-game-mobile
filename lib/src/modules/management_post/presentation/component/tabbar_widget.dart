part of '../page/management_post_page.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
      {super.key,
      required this.label,
      required this.isSelected,
      this.onTap,
      this.number,
      this.showNumber});
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final int? number;
  final bool? showNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 37.w,
        decoration: BoxDecoration(
          color: isSelected ? ColorName.black1E1E1E : Colors.transparent,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              showNumber == null
                  ? number == null
                      ? '$label - 0'
                      : '$label - $number'
                  : label,
              style: isSelected
                  ? context.textTheme.headlineSmall
                  : context.textTheme.headlineSmall
                      .copyWith(color: ColorName.greyBBBBBB),
            ),
          ),
        ),
      ),
    );
  }
}
