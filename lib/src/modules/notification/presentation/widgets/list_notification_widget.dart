part of '../pages/notification_page.dart';

class ListNotificationsWidget extends StatefulWidget {
  const ListNotificationsWidget(
      {super.key,
      required this.notifications,
      required this.refresh,
      required this.loadmore});

  final List<NotificationModel> notifications;
  final VoidCallback refresh;
  final Future<void> Function() loadmore;

  @override
  State<ListNotificationsWidget> createState() =>
      _ListNotificationsWidgetState();
}

class _ListNotificationsWidgetState extends State<ListNotificationsWidget> {
  bool isLoadingMore = false;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        if (mounted) {
          setState(() {
            isLoadingMore = true;
          });
        }
        await widget.loadmore();
        if (mounted) {
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        widget.refresh();
      },
      color: ColorName.primary,
      child: Stack(
        children: [
          ListView(),
          widget.notifications.isEmpty
              ? Center(
                  child: NoPostWidget(
                      content: context.s.there_are_no_notification),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: widget.notifications.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.notifications.length) {
                      if (isLoadingMore) {
                        return const SizedBox(
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorName.primary,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return NotificationCardWidget(
                        notification: widget.notifications[index],
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }
}
