part of '../pages/home_page.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void refresh() {
    context.read<HomeCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        refresh();
      },
      color: ColorName.primary,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      //account && search bar
                      padding: const EdgeInsets.symmetric(
                          horizontal: UIConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //account
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                    authenticated: (user) => UserInforWidget(
                                        user: user), //user infor
                                    orElse: () =>
                                        const LoginTextWidget(), //text login, register
                                  ) ??
                                  const SizedBox.shrink();
                            },
                          ),
                          //search bar
                          SearchBarWidget(
                            focusNode: _focusNode,
                            hintText: context.s.search,
                            onSearch: () {
                              context.router
                                  .push(const SearchRoute())
                                  .then((_) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    //banners && categories
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //banner slider
                        state.banners.isNotEmpty
                            ? BannerSliderWidget(
                                banners: state.banners,
                              )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: UIConstants.padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //category
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      context.s.category_game.toUpperCase(),
                                      style: context.textTheme.titleLarge,
                                    ),
                                    const Divider(
                                      color: ColorName.grey353535,
                                      thickness: 1,
                                    ),

                                    //category list
                                    state.categories.isNotEmpty
                                        ? GameCategoryWidget(
                                            categories: state.categories,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //highlight &&  products
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: UIConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //highlight
                          Padding(
                            padding: EdgeInsets.only(bottom: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //hightlight text
                                Text(
                                  'TOP RATING',
                                  style: context.textTheme.titleLarge,
                                ),
                                const Divider(
                                  color: ColorName.grey353535,
                                  thickness: 1,
                                ),
                                //hightlight
                                const HighlightWidget(),
                              ],
                            ),
                          ),

                          //gridview products text
                          Text(
                            context.s.suggest_for_you.toUpperCase(),
                            style: context.textTheme.titleLarge,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.w),
                            child: const Divider(
                              color: ColorName.grey353535,
                              thickness: 1,
                            ),
                          ),
                          // gridview products
                          state.products.isNotEmpty
                              ? GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 173 / 253,
                                    crossAxisSpacing: 12.w,
                                    mainAxisSpacing: 16.w,
                                  ),
                                  itemCount: state.products
                                      .expand((category) => category.data)
                                      .length,
                                  itemBuilder: (context, index) {
                                    final allProducts = state.products
                                        .expand((categoryProducts) =>
                                            categoryProducts.data)
                                        .toList();
                                    final product = allProducts[index];
                                    return GestureDetector(
                                      onTap: () {
                                        context.router.push(ProductRoute(
                                            productId: product.id));
                                      },
                                      child: ProductCardWidget(
                                        product: product,
                                        onLoading: () {
                                          context
                                              .read<HomeCubit>()
                                              .emitToLoading();
                                        },
                                        unLoading: () {
                                          context
                                              .read<HomeCubit>()
                                              .emitToUnLoading();
                                        },
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox.shrink()
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
      ),
    );
  }
}
