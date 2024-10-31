part of '../page/management_post_page.dart';

class ManagementPostBody extends StatelessWidget {
  const ManagementPostBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabbarCubit, TabbarState>(
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: UIConstants.padding),
              child: Column(
                children: [
                  ScrollviewTabbarWidget(
                    deleteCount: state.deletedCount,
                    pendingCount: state.pedingCount,
                    sellingCount: state.sellingCount,
                    rejectCount: state.rejectedCount,
                    soldCount: state.soldCount,
                    currentTab: state.index,
                    onSellingTab: () {
                      context.read<TabbarCubit>().onTapToSellingTab();
                    },
                    onPendingTab: () {
                      context.read<TabbarCubit>().onTapToPendingTab();
                    },
                    onRejectTab: () {
                      context.read<TabbarCubit>().onTapToRejectTab();
                    },
                    onSoldTab: () {
                      context.read<TabbarCubit>().onTapToSoldTab();
                    },
                    onDeletedTab: () {
                      context.read<TabbarCubit>().onTapToDeleteTab();
                    },
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Offstage(
                          offstage: state.index != 1,
                          child: BlocBuilder<PostPublicCubit, PostPublicState>(
                            builder: (context, state) {
                              return SellingProductsWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<PostPublicCubit>().loadmore(),
                                onTapProduct: (productId) {
                                  context.router.push(ViewPostRoute(
                                      productId: productId,
                                      enableToUpdatePost: true,
                                      navigationToManagementPostIndex: 1));
                                },
                                refresh: () {
                                  context.read<PostPublicCubit>().refresh();
                                  context
                                      .read<TabbarCubit>()
                                      .getManagementPost();
                                },
                              );
                            },
                          ),
                        ),
                        Offstage(
                          offstage: state.index != 2,
                          child:
                              BlocBuilder<PostPendingCubit, PostPendingState>(
                            builder: (context, state) {
                              return SoldProductsWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<PostPendingCubit>().loadmore(),
                                onTapToProduct: (productId) {
                                  context.router.push(ViewPostRoute(
                                      productId: productId,
                                      enableToUpdatePost: true,
                                      navigationToManagementPostIndex: 2));
                                },
                                refresh: () {
                                  context.read<PostPendingCubit>().refresh();
                                  context
                                      .read<TabbarCubit>()
                                      .getManagementPost();
                                },
                              );
                            },
                          ),
                        ),
                        Offstage(
                          offstage: state.index != 3,
                          child: BlocBuilder<PostRejectCubit, PostRejectState>(
                            builder: (context, state) {
                              return SoldProductsWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<PostRejectCubit>().loadmore(),
                                onTapToProduct: (productId) {
                                  context.router.push(ViewPostRoute(
                                      productId: productId,
                                      enableToUpdatePost: true,
                                      navigationToManagementPostIndex: 3));
                                },
                                refresh: () {
                                  context.read<PostRejectCubit>().refresh();
                                  context
                                      .read<TabbarCubit>()
                                      .getManagementPost();
                                },
                              );
                            },
                          ),
                        ),
                        Offstage(
                          offstage: state.index != 4,
                          child: BlocBuilder<PostSoldCubit, PostSoldState>(
                            builder: (context, state) {
                              return SoldProductsWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<PostSoldCubit>().loadmore(),
                                onTapToProduct: (productId) {
                                  context.router.push(ViewPostRoute(
                                      productId: productId,
                                      enableToUpdatePost: false,
                                      navigationToManagementPostIndex: 4));
                                },
                                refresh: () {
                                  context.read<PostSoldCubit>().refresh();
                                  context
                                      .read<TabbarCubit>()
                                      .getManagementPost();
                                },
                              );
                            },
                          ),
                        ),
                        Offstage(
                          offstage: state.index != 5,
                          child: BlocBuilder<PostDeleteCubit, PostDeleteState>(
                            builder: (context, state) {
                              return SoldProductsWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<PostDeleteCubit>().loadmore(),
                                onTapToProduct: (productId) {
                                  context.router.push(ViewPostRoute(
                                      productId: productId,
                                      enableToUpdatePost: false));
                                },
                                refresh: () {
                                  context.read<PostDeleteCubit>().refresh();
                                  context
                                      .read<TabbarCubit>()
                                      .getManagementPost();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (state.isLoading == true)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}
