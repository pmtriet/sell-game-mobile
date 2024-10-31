part of '../page/shop_profile_page.dart';

class ShopProfileBody extends StatelessWidget {
  const ShopProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    int soldProductNumber = 0;
    int sellingProductNumber = 0;
    return BlocListener<ShopProfileCubit, ShopProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (isLoading, shop, error) {
            if (error != null) {
              // context.showError(error);
              AppDialogs.show(type: AlertType.error, content: error);
            }
          },
        );
      },
      child: BlocBuilder<ShopProfileCubit, ShopProfileState>(
        builder: (context, state) {
          return state.when(
            loaded: (isLoading, shop, _) {
              if (shop != null) {
                soldProductNumber = shop.count.transactions;
                sellingProductNumber = shop.count.products;
              }
              return Stack(
                children: [
                  shop != null
                      ? Column(
                          children: [
                            //shop images, name
                            ShopInforWidget(shop: shop),

                            //follow button
                            // BlocBuilder<AuthCubit, AuthState>(
                            //   builder: (context, state) {
                            //     return Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: UIConstants.padding),
                            //       child: FollowButtonWidget(
                            //         onPressed: () {
                            //           state.maybeWhen(
                            //               authenticated: (user) => context
                            //                   .read<ShopProfileCubit>()
                            //                   .followShop(),
                            //               orElse: () => AppDialogs.show(
                            //                     type: AlertType.error,
                            //                     content: context.s.login_please,
                            //                     action1: () => context.router
                            //                         .push(const AuthRoute()),
                            //                   ));
                            //         },
                            //       ),
                            //     );
                            //   },
                            // ),

                            //selling infor
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: UIConstants.padding,
                                  right: UIConstants.padding,
                                  bottom: UIConstants.padding),
                              child: ShopStatsWidget(
                                argReview: shop.avgRating,
                                soldNumber: soldProductNumber,
                                sellingNumber: sellingProductNumber,
                                createdAt: shop.createdAt,
                              ),
                            ),

                            //tabbar
                            BlocBuilder<TabbarCubit, TabbarState>(
                                builder: (context, state) {
                              return state.index == 1
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16,
                                          right: UIConstants.padding,
                                          left: UIConstants.padding),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TabItemWidget(
                                            label: context.s.showing,
                                            isSelected: true,
                                            onTap: null,
                                            number: sellingProductNumber,
                                          ),
                                          TabItemWidget(
                                            label: context.s.sold,
                                            isSelected: false,
                                            onTap: () {
                                              context
                                                  .read<TabbarCubit>()
                                                  .onTapToSoldTab();
                                            },
                                            number: soldProductNumber,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16,
                                          right: UIConstants.padding,
                                          left: UIConstants.padding),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TabItemWidget(
                                            label: context.s.showing,
                                            isSelected: false,
                                            onTap: () {
                                              context
                                                  .read<TabbarCubit>()
                                                  .onTapToSellingTab();
                                            },
                                            number: sellingProductNumber,
                                          ),
                                          TabItemWidget(
                                            label: context.s.sold,
                                            isSelected: true,
                                            number: soldProductNumber,
                                          ),
                                        ],
                                      ),
                                    );
                            }),

                            //products
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: UIConstants.padding),
                              child: BlocBuilder<TabbarCubit, TabbarState>(
                                builder: (context, state) {
                                  return Stack(
                                    children: [
                                      Offstage(
                                        offstage:
                                            state.index == 2 ? true : false,
                                        child: BlocBuilder<SellingProductsCubit,
                                            SellingProductsState>(
                                          builder: (context, state) {
                                            return state.products != null
                                                ? SellingProductsWidget(
                                                    products: state.products!,
                                                    loadMore: () => context
                                                        .read<
                                                            SellingProductsCubit>()
                                                        .loadmore(),
                                                    onTapProduct: (productId) {
                                                      context.router.push(
                                                          ProductRoute(
                                                              productId:
                                                                  productId));
                                                    },
                                                    refresh: () {
                                                      context
                                                          .read<
                                                              SellingProductsCubit>()
                                                          .refresh();
                                                    },
                                                  )
                                                : const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                      Offstage(
                                        offstage:
                                            state.index == 1 ? true : false,
                                        child: BlocBuilder<SoldProductsCubit,
                                            SoldProductsState>(
                                          builder: (context, state) {
                                            return state.products != null
                                                ? SoldProductsWidget(
                                                    products: state.products!,
                                                    loadMore: () => context
                                                        .read<
                                                            SoldProductsCubit>()
                                                        .loadmore(),
                                                    onTapToProduct:
                                                        (productId) {
                                                      context.router.push(
                                                          ProductRoute(
                                                              productId:
                                                                  productId,
                                                              sold: true));
                                                    },
                                                    refresh: () {
                                                      context
                                                          .read<
                                                              SoldProductsCubit>()
                                                          .refresh();
                                                    },
                                                  )
                                                : const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )),
                          ],
                        )
                      : const SizedBox.shrink(),
                  if (isLoading == true)
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
        },
      ),
    );
  }
}
