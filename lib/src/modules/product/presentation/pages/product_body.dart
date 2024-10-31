part of 'product_page.dart';

class ProductBody extends StatelessWidget {
  final int productId;
  final bool? sold;
  const ProductBody({super.key, required this.productId, this.sold});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppDialogs.show(
              content: context.s.error_unexpected, type: AlertType.error);
        }
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: ColorName.background,
                appBar: AppBar(
                  titleSpacing: 0,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: ColorName.background,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 24.sp,
                      color: ColorName.green3BD9AC,
                    ),
                    onPressed: () {
                      context.router.maybePop();
                    },
                  ),
                  // actions: [
                  //   IconButton(
                  //     icon: Assets.icons.share.svg(
                  //       width: 20.w,
                  //       height: 20.h,
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  // ],
                ),
                body: Stack(
                  children: [
                    state.product != null
                        ? Stack(
                            children: [
                              SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: 60.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CarouselSlider(
                                      items: state.product!.images
                                          .map((image) => SizedBox(
                                                width: double.infinity,
                                                child: image.filePath.isNotEmpty
                                                    ? CacheImageWidget(
                                                        url: image.filePath,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Assets.icons.deletedImage
                                                        .svg(),
                                              ))
                                          .toList(),
                                      options: CarouselOptions(
                                        viewportFraction: 1,
                                        height: 200.h,
                                        autoPlay:
                                            state.product!.images.length > 1,
                                        enableInfiniteScroll:
                                            state.product!.images.length > 1,
                                        enlargeCenterPage: true,
                                        onPageChanged: (index, reason) {
                                          context
                                              .read<ProductCubit>()
                                              .updateCarouselIndex(index);
                                        },
                                      ),
                                    ),
                                    // Page Indicator
                                    BlocBuilder<ProductCubit, ProductState>(
                                      builder: (context, state) {
                                        final currentIndex = state.maybeWhen(
                                          loaded: (isLoading, _, __, ___,
                                                  carouselIndex, error) =>
                                              carouselIndex,
                                          orElse: () => 0,
                                        );
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: state.product!.images
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<ProductCubit>()
                                                    .updateCarouselIndex(
                                                        entry.key);
                                              },
                                              child: Container(
                                                width: currentIndex == entry.key
                                                    ? 50.w
                                                    : 4.w,
                                                height: 4.h,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.h,
                                                    horizontal: 4.w),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                  color: currentIndex ==
                                                          entry.key
                                                      ? ColorName.primary
                                                      : ColorName.grey626262,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: UIConstants.padding),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getProductTypeFromString(state
                                                              .product!
                                                              .productType) ==
                                                          ProductType.b2c &&
                                                      state.product!.saleOff !=
                                                          0
                                                  ? ProductPriceWidget(
                                                      discount: state
                                                          .product!.saleOff,
                                                      originalPrice: state
                                                          .product!.price
                                                          .toVND(),
                                                      price: (state.product!
                                                              .currentPrice)
                                                          .toInt()
                                                          .toVND(),
                                                      productId:
                                                          state.product!.id,
                                                      onLoading: () {
                                                        context
                                                            .read<
                                                                ProductCubit>()
                                                            .emitToLoading();
                                                      },
                                                      unLoading: () {
                                                        context
                                                            .read<
                                                                ProductCubit>()
                                                            .emitToUnloading();
                                                      },
                                                    )
                                                  : ProductPriceWidget(
                                                      discount: null,
                                                      originalPrice: null,
                                                      price:
                                                          (state.product!.price)
                                                              .toInt()
                                                              .toVND(),
                                                      productId:
                                                          state.product!.id,
                                                      onLoading: () {
                                                        context
                                                            .read<
                                                                ProductCubit>()
                                                            .emitToLoading();
                                                      },
                                                      unLoading: () {
                                                        context
                                                            .read<
                                                                ProductCubit>()
                                                            .emitToUnloading();
                                                      },
                                                    ),
                                              SizedBox(height: 8.h),
                                              ProductTitleWidget(
                                                title: state.product!.title,
                                                gameName: state
                                                    .product!.category.name,
                                                id: state.product!.code,
                                                timeAgo: state
                                                    .product!.createdAt
                                                    .toDurationFormat(),
                                              ),
                                              SizedBox(height: 16.h),
                                              ProductDetailsWidget(
                                                product: state.product!,
                                              ),
                                              SizedBox(height: 16.h),
                                              AccountLinkWidget(
                                                title: 'Liên kết tài khoản',
                                                accountName: state.product!
                                                    .signInMethod.title,
                                              ),
                                              SizedBox(height: 16.h),
                                              DescriptionContainerWidget(
                                                  title: 'Mô tả chi tiết',
                                                  description: state
                                                      .product!.description),
                                              SizedBox(height: 16.h),
                                            ],
                                          ),
                                        ),
                                        //shop infor when product is c2c
                                        if (getProductTypeFromString(
                                                state.product!.productType) ==
                                            ProductType.c2c)
                                          ShopInforWidget(
                                            shop: state.product!.account,
                                          ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: UIConstants.padding),
                                          child: Column(
                                            children: [
                                              //shop products
                                              if (state.sellerProducts != null)
                                                if (state.sellerProducts!.data
                                                    .isNotEmpty)
                                                  ListShopProductsWidget(
                                                    shopProducts:
                                                        state.sellerProducts!,
                                                    shopId: state
                                                        .product!.account.id,
                                                    shopName: state.product!
                                                        .account.fullname,
                                                    onLoading: () {
                                                      context
                                                          .read<ProductCubit>()
                                                          .emitToLoading();
                                                    },
                                                    unLoading: () {
                                                      context
                                                          .read<ProductCubit>()
                                                          .emitToUnloading();
                                                    },
                                                  ),

                                              //suggest products
                                              (state.suggestProducts != null)
                                                  ? (state.suggestProducts!.data
                                                          .isNotEmpty)
                                                      ? ListSuggestProductsWidget(
                                                          suggestProducts: state
                                                              .suggestProducts!,
                                                          onLoading: () {
                                                            context
                                                                .read<
                                                                    ProductCubit>()
                                                                .emitToLoading();
                                                          },
                                                          unLoading: () {
                                                            context
                                                                .read<
                                                                    ProductCubit>()
                                                                .emitToUnloading();
                                                          },
                                                        )
                                                      : const SizedBox(
                                                          height: 80,
                                                        )
                                                  : const SizedBox(
                                                      height: 80,
                                                    )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: ColorName.background,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 16.w),
                                  child: BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, authState) {
                                      return ButtonWidget(
                                        title: sold == null
                                            ? 'Mua ngay'
                                            : context.s.sold,
                                        onTextButtonPressed: sold == null
                                            ? () {
                                                authState.when(
                                                  authenticated: (user) {
                                                    context.router.push(
                                                        BuyRoute(
                                                            product: state
                                                                .product!));
                                                  },
                                                  unauthenticated: () {
                                                    AppDialogs.show(
                                                        type: AlertType.notice,
                                                        content: context
                                                            .s.login_please,
                                                        action1: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          context.router.push(
                                                              const AuthRoute());
                                                        });
                                                  },
                                                  loading: () {},
                                                  error: (error) {},
                                                );
                                              }
                                            : () {},
                                        icon: sold == null
                                            ? Assets.icons.cart.svg()
                                            : null,
                                        isDisable: sold != null,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox.fromSize(),
                    if (state.isLoading)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                  ],
                )),
          );
        },
      ),
    );
  }
}
