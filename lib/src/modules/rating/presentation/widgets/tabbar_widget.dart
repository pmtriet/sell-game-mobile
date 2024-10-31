part of '../page/rating_page.dart';

class TabbarWidget extends StatelessWidget {
  const TabbarWidget({super.key, required this.currentTab, required this.onNotRateTab, required this.onRatedTab, required this.onBuyerRatingTab});
  final int currentTab;
  final VoidCallback onNotRateTab;
  final VoidCallback onRatedTab;
  final VoidCallback onBuyerRatingTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabItemWidget(
                label: context.s.not_rating_yet,
                isSelected: currentTab == 1,
                onTap: onNotRateTab,
              ),
              TabItemWidget(
                label: context.s.rated,
                isSelected: currentTab == 2,
                onTap: onRatedTab,
              ),
              TabItemWidget(
                label: context.s.from_buyer,
                isSelected: currentTab == 3,
                onTap: onBuyerRatingTab,
              ),
            ],
          );
  }
}