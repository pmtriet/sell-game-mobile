part of '../pages/saved_post_page.dart';

class ListviewSavedPostWidget extends StatefulWidget {
  const ListviewSavedPostWidget(
      {super.key,
      required this.savedPosts,
      required this.refresh,
      required this.loadmore,
      required this.deleteSavedPost});

  final List<SavedPostModel> savedPosts;
  final VoidCallback refresh;
  final Future<void> Function() loadmore;
  final Function(int id) deleteSavedPost;

  @override
  State<ListviewSavedPostWidget> createState() =>
      _ListviewSavedPostWidgetState();
}

class _ListviewSavedPostWidgetState extends State<ListviewSavedPostWidget> {
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
          widget.savedPosts.isEmpty
              ? Center(
                  child:
                      NoPostWidget(content: context.s.there_are_no_posts_yet),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: widget.savedPosts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.savedPosts.length) {
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
                        onTap: () => context.router.push(ProductRoute(
                            productId: widget.savedPosts[index].id)),
                        child: SavedPostWidget(
                          post: widget.savedPosts[index],
                          deleteSavedPost: (id) => widget.deleteSavedPost(id),
                        ),
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }
}
