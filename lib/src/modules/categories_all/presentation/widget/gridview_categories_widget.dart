part of '../page/categories_all_page.dart';

class GridviewCategoriesWidget extends StatefulWidget {
  const GridviewCategoriesWidget({
    super.key,
    required this.categories,
    required this.refresh,
    // required this.loadMore,
  });

  final List<Category> categories;
  final Future<void> Function() refresh;
  // final Future<void> Function() loadMore;

  @override
  GridviewCategoriesWidgetState createState() =>
      GridviewCategoriesWidgetState();
}

class GridviewCategoriesWidgetState extends State<GridviewCategoriesWidget> {
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
        // await widget.loadMore();
        if (mounted) {
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    }
  }

  void _refresh() {
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              _refresh();
            },
            color: ColorName.primary,
            child: Stack(
              children: [
                ListView(),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 111 / 145,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.w,
                  ),
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    // if (index == widget.categories.length) {
                    //   if (isLoadingMore) {
                    //     return const SizedBox(
                    //       height: 80,
                    //       child: Center(
                    //         child: CircularProgressIndicator(
                    //           color: ColorName.primary,
                    //         ),
                    //       ),
                    //     );
                    //   } else {
                    //     return const SizedBox.shrink();
                    //   }
                    // } else
                    {
                      return GestureDetector(
                        onTap: () {
                          //TODO: push to categories page
                        },
                        child: CategoryCardWidget(
                          category: widget.categories[index],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
