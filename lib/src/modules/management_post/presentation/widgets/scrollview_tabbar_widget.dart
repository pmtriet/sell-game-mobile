part of '../page/management_post_page.dart';

class ScrollviewTabbarWidget extends StatelessWidget {
  const ScrollviewTabbarWidget(
      {super.key,
      required this.deleteCount,
      required this.pendingCount,
      required this.sellingCount,
      required this.rejectCount,
      required this.soldCount,
      required this.currentTab,
      required this.onSellingTab,
      required this.onPendingTab,
      required this.onRejectTab,
      required this.onSoldTab,
      required this.onDeletedTab});
  final int currentTab;
  final int deleteCount;
  final int pendingCount;
  final int sellingCount;
  final int rejectCount;
  final int soldCount;
  final VoidCallback onSellingTab;
  final VoidCallback onPendingTab;
  final VoidCallback onRejectTab;
  final VoidCallback onSoldTab;
  final VoidCallback onDeletedTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TabItemWidget(
                  label: context.s.selling,
                  isSelected: currentTab == 1,
                  onTap: onSellingTab,
                  number: sellingCount,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TabItemWidget(
                  label: context.s.pending,
                  isSelected: currentTab == 2,
                  onTap: onPendingTab,
                  number: pendingCount,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TabItemWidget(
                  label: context.s.rejected,
                  isSelected: currentTab == 3,
                  onTap: onRejectTab,
                  number: rejectCount,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TabItemWidget(
                  label: context.s.sold,
                  isSelected: currentTab == 4,
                  onTap: onSoldTab,
                  number: soldCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
