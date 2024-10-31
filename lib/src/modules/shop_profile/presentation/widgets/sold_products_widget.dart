part of '../page/shop_profile_page.dart';

class SoldProductsWidget extends StatefulWidget {
  const SoldProductsWidget(
      {super.key,
      required this.products,
      required this.loadMore,
      required this.onTapToProduct,
      required this.refresh});
  final List<MarketplaceProductModel> products;
  final Future<void> Function() loadMore;
  final Function(int productId) onTapToProduct;
  final VoidCallback refresh;

  @override
  State<SoldProductsWidget> createState() => _SoldProductsWidgetState();
}

class _SoldProductsWidgetState extends State<SoldProductsWidget> {
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
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        widget.refresh();
      },
      color: ColorName.primary,
      child: Stack(
        children: [
          ListView(),
          widget.products.isEmpty
              ? Center(
                  child: NoPostWidget(
                      content: context.s.there_are_no_notification),
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  itemCount: widget.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.products.length) {
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
                      return ShopProductWidget(
                        product: widget.products[index],
                        onTap: () =>
                            widget.onTapToProduct(widget.products[index].id),
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }
}
