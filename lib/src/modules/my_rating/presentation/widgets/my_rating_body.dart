part of '../page/my_rating_page.dart';

class MyRatingBody extends StatelessWidget {
  const MyRatingBody({super.key});

  @override
  Widget build(BuildContext context) {
    int currentTab = 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TabbarCubit, TabbarState>(
            listener: (context, state) {
              currentTab = state.index;
            },
          ),
          BlocListener<NoRatingYetCubit, NoRatingYetState>(
            listener: (context, state) {
              if (currentTab == 1) {
                if (state.isLoading) {
                  context.read<TabbarCubit>().onLoadingData();
                } else {
                  context.read<TabbarCubit>().unLoadingData();
                }
              }
            },
          ),
          BlocListener<RatedCubit, RatedState>(
            listener: (context, state) {
              if (currentTab == 2) {
                if (state.isLoading) {
                  context.read<TabbarCubit>().onLoadingData();
                } else {
                  context.read<TabbarCubit>().unLoadingData();
                }
              }
            },
          ),
          BlocListener<BuyerRatingCubit, BuyerRatingState>(
            listener: (context, state) {
              if (currentTab == 3) {
                if (state.isLoading) {
                  context.read<TabbarCubit>().onLoadingData();
                } else {
                  context.read<TabbarCubit>().unLoadingData();
                }
              }
            },
          ),
        ],
        child: BlocBuilder<TabbarCubit, TabbarState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    //tabbar
                    TabbarWidget(
                      currentTab: state.index,
                      onNotRatingYetTab: () {
                        context.read<TabbarCubit>().onTapToNotRatingYetTab();
                      },
                      onRatedTab: () {
                        context.read<TabbarCubit>().onTapToRatedTab();
                      },
                      onRatingFromBuyerTab: () {
                        context.read<TabbarCubit>().onTapToBuyerRatingTab();
                      },
                    ),
                    //data
                    Expanded(
                        child: Stack(
                      children: [
                        //not rating yet
                        Offstage(
                          offstage: state.index != 1,
                          child:
                              BlocBuilder<NoRatingYetCubit, NoRatingYetState>(
                            builder: (context, state) {
                              return ListviewNotRatingYetOrdersWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<NoRatingYetCubit>().loadmore(),
                                refresh: () {
                                  context.read<NoRatingYetCubit>().refresh();
                                },
                              );
                            },
                          ),
                        ),
                        //rated
                        Offstage(
                          offstage: state.index != 2,
                          child: BlocBuilder<RatedCubit, RatedState>(
                            builder: (context, state) {
                              return ListviewRatedOrdersWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<RatedCubit>().loadmore(),
                                refresh: () {
                                  context.read<RatedCubit>().refresh();
                                },
                              );
                            },
                          ),
                        ),
                        //rating from buyer
                        Offstage(
                          offstage: state.index != 3,
                          child:
                              BlocBuilder<BuyerRatingCubit, BuyerRatingState>(
                            builder: (context, state) {
                              return ListviewBuyerRatingWidget(
                                products: state.products ?? [],
                                loadMore: () =>
                                    context.read<BuyerRatingCubit>().loadmore(),
                                refresh: () {
                                  context.read<BuyerRatingCubit>().refresh();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ))
                  ],
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
        ),
      ),
    );
  }
}
