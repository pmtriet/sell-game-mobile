part of '../pages/transaction_history_page.dart';

class ListViewOrdersWidget extends StatefulWidget {
  const ListViewOrdersWidget(
      {super.key,
      required this.orders,
      required this.refresh,
      required this.loadMore,
      required this.onTapToOrder});

  final List<OrderModel> orders;
  final Future<void> Function() refresh;
  final Future<void> Function() loadMore;
  final Function(int transactionId) onTapToOrder;

  @override
  State<ListViewOrdersWidget> createState() => _ListViewOrdersWidgetState();
}

class _ListViewOrdersWidgetState extends State<ListViewOrdersWidget> {
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
        await widget.loadMore();
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
    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
          color: ColorName.primary,
          onRefresh: () async {
            await widget.refresh();
          },
          child: Stack(
            children: [
              ListView(),
              widget.orders.isEmpty
                  ? Center(
                      child: NoPostWidget(
                          content: context.s.there_are_no_transaction),
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      itemCount: widget.orders.length + 1,
                      itemBuilder: (context, index) {
                        if (index == widget.orders.length) {
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
                          return GestureDetector(
                              onTap: () {
                                widget.onTapToOrder(widget.orders[index].id);
                              },
                              child: OrderWidget(order: widget.orders[index]));
                        }
                      },
                    ),
            ],
          ),
        )),
      ],
    );
  }
}
