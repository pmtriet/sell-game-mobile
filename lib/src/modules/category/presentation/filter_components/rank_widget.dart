part of '../pages/category_page.dart';
class RankWidget extends StatelessWidget {
  const RankWidget(
      {super.key,
      required this.rankName,
      required this.onTap,
      required this.isSelected});
  final String rankName;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ColorName.primary : ColorName.grey353535,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              rankName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.contentSmall,
            ),
          ),
        ),
      ),
    );
  }
}
