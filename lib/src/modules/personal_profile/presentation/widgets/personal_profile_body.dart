part of '../pages/personal_profile_page.dart';

class PersonalProfileBody extends StatelessWidget {
  const PersonalProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: context.router.maybePop,
            icon: const Icon(
              Icons.arrow_back,
              color: ColorName.primary,
            )),
        titleSpacing: 0,
        title: Text(
          context.s.personal_profile.toUpperCase(),
          style: context.textTheme.bodyLarge,
        ),
        actions: [
          //edit button
          IconButton(
            onPressed: () {
              context.router.push(const PersonalProfileEditRoute());
            },
            icon: Assets.icons.edit.svg(),
          ),
        ],
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorName.background,
      ),
      backgroundColor: ColorName.background,
      body: BlocListener<PersonalProfileCubit, PersonalProfileState>(
        listener: (context, state) {
          if (state.isError != null) {
            AppDialogs.show(
              type: AlertType.error,
              content: context.s.error_unexpected,
              action1: () {
                getIt<AuthCubit>().logout();
                Navigator.of(context).pop();
                context.router.push(const AuthRoute());
              },
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) {
                return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        state.shopInfor != null
                            ? Column(
                                children: [
                                  //avatar, name, followings, followers, cover img
                                  const BaseInforWidget(),
                                  //stats summary
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: UIConstants.padding),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: ShopStatsWidget(
                                          user: state.shopInfor!),
                                    ),
                                  ),
                                  //tabbar
                                  BlocBuilder<TabbarCubit, TabbarState>(
                                    builder: (context, state) {
                                      return Padding(
                                        padding: const EdgeInsets.all(
                                            UIConstants.padding),
                                        child: TabbarWidget(
                                          currentTab: state.index,
                                          sellingCount: state.sellingCount,
                                          soldCount: state.soldCount,
                                          onSellingTab: () {
                                            context
                                                .read<TabbarCubit>()
                                                .onTapToSellingTab();
                                          },
                                          onSoldTab: () {
                                            context
                                                .read<TabbarCubit>()
                                                .onTapToSoldTab();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  //list products
                                  Expanded(
                                    child:
                                        BlocBuilder<TabbarCubit, TabbarState>(
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: UIConstants.padding,
                                              right: UIConstants.padding,
                                              bottom: UIConstants.padding),
                                          child: Stack(
                                            children: [
                                              Offstage(
                                                offstage: state.index != 1,
                                                child: BlocBuilder<
                                                    ProductSellingCubit,
                                                    ProductSellingState>(
                                                  builder: (context, state) {
                                                    return SellingProductsWidget(
                                                      products: state.products,
                                                      loadMore: () => context
                                                          .read<
                                                              ProductSellingCubit>()
                                                          .loadmore(),
                                                      onTapProduct:
                                                          (productId) {
                                                        context.router.push(
                                                            ViewPostRoute(
                                                                productId:
                                                                    productId,
                                                                enableToUpdatePost:
                                                                    true,
                                                                navigationToManagementPostIndex:
                                                                    1));
                                                      },
                                                      refresh: () {
                                                        context
                                                            .read<
                                                                ProductSellingCubit>()
                                                            .refresh();

                                                        context
                                                            .read<TabbarCubit>()
                                                            .refresh();
                                                        
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              Offstage(
                                                offstage: state.index != 2,
                                                child: BlocBuilder<
                                                    ProductSoldCubit,
                                                    ProductSoldState>(
                                                  builder: (context, state) {
                                                    return SoldProductsWidget(
                                                      products: state.products,
                                                      loadMore: () => context
                                                          .read<
                                                              ProductSoldCubit>()
                                                          .loadmore(),
                                                      onTapToProduct:
                                                          (productId) {
                                                        context.router
                                                            .push(ViewPostRoute(
                                                          productId: productId,
                                                          enableToUpdatePost:
                                                              false,
                                                        ));
                                                      },
                                                      refresh: () {
                                                        context
                                                            .read<
                                                                ProductSoldCubit>()
                                                            .refresh();
                                                        
                                                        context
                                                            .read<TabbarCubit>()
                                                            .refresh();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        if (state.isLoading)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withOpacity(0.5),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                      ],
                    );
                  },
                );
              },
              orElse: () {
                AppDialogs.show(
                  type: AlertType.error,
                  content: context.s.error_unexpected,
                  action1: () {
                    getIt<AuthCubit>().logout();
                    Navigator.of(context).pop();
                    context.router.push(const AuthRoute());
                  },
                );
                return SizedBox.fromSize();
              },
            );
          },
        ),
      ),
    );
  }
}
