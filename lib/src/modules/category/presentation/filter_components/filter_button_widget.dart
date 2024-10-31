part of '../pages/category_page.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget(
      {super.key, required this.enable, required this.title, required this.onTap});
  final bool enable;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 135.w,
        height: 37.w,
        decoration: BoxDecoration(
          color: enable ? ColorName.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(
            color: ColorName.primary,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: enable
                ? context.textTheme.titleMedium
                : context.textTheme.caption,
          ),
        ),
      ),
    );
  }
}
