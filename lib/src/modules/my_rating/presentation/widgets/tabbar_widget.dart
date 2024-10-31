part of '../page/my_rating_page.dart';

class TabbarWidget extends StatelessWidget {
  const TabbarWidget(
      {super.key,
      required this.currentTab,
      required this.onNotRatingYetTab,
      required this.onRatedTab,
      required this.onRatingFromBuyerTab});
  final int currentTab;
  final VoidCallback onNotRatingYetTab;
  final VoidCallback onRatedTab;
  final VoidCallback onRatingFromBuyerTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TabItemWidget(
                    label: context.s.not_rating_yet,
                    isSelected: currentTab == 1,
                    onTap: onNotRatingYetTab,
                    showNumber: true),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TabItemWidget(
                    label: context.s.rated,
                    isSelected: currentTab == 2,
                    onTap: onRatedTab,
                    showNumber: true),
              ),
              TabItemWidget(
                  label: context.s.from_buyer,
                  isSelected: currentTab == 3,
                  onTap: onRatingFromBuyerTab,
                  showNumber: true),
            ],
          ),
        ),
      ),
    );
  }
}
