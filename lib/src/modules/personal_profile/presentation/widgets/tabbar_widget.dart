part of '../pages/personal_profile_page.dart';

class TabbarWidget extends StatelessWidget {
  const TabbarWidget({
    super.key,
    required this.sellingCount,
    required this.soldCount,
    required this.currentTab,
    required this.onSellingTab,
    required this.onSoldTab,
  });
  final int currentTab;
  final int sellingCount;
  final int soldCount;
  final VoidCallback onSellingTab;
  final VoidCallback onSoldTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TabItemWidget(
          label: context.s.showing,
          isSelected: currentTab == 1,
          onTap: onSellingTab,
          number: sellingCount,
        ),
        TabItemWidget(
          label: context.s.sold,
          isSelected: currentTab == 2,
          onTap: onSoldTab,
          number: soldCount,
        ),
      ],
    );
  }
}
