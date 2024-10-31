part of '../pages/transaction_history_page.dart';

class ListViewPaymentWidget extends StatefulWidget {
  const ListViewPaymentWidget(
      {super.key,
      required this.transactions,
      required this.refresh,
      required this.loadMore});
  final List<PaymentHistoryModel> transactions;
  final Future<void> Function() refresh;
  final Future<void> Function() loadMore;

  @override
  State<ListViewPaymentWidget> createState() => _ListViewPaymentWidgetState();
}

class _ListViewPaymentWidgetState extends State<ListViewPaymentWidget> {
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
              widget.transactions.isEmpty
                  ? Center(
                      child: NoPostWidget(
                          content: context.s.there_are_no_transaction),
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      itemCount: widget.transactions.length + 1,
                      itemBuilder: (context, index) {
                        if (index == widget.transactions.length) {
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
                          return PaymentWidget(
                              transactionHistory: widget.transactions[index]);
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
