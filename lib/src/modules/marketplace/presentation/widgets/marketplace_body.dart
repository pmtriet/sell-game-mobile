part of '../page/marketplace_page.dart';

class MarketplaceBody extends StatefulWidget {
  const MarketplaceBody({super.key});

  @override
  State<MarketplaceBody> createState() => _MarketplaceBodyState();
}

class _MarketplaceBodyState extends State<MarketplaceBody> {
  void fetchData() {
    context.read<MarketplaceCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        fetchData();
      },
      color: ColorName.primary,
      child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
        builder: (context, state) {
          return Stack(
            children: [
              ListView(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UIConstants.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          context.s.shopping.toUpperCase(),
                          style: context.textTheme.displayLarge,
                        ),
                      ),
                      BlocBuilder<MarketplaceCubit, MarketplaceState>(
                        builder: (context, state) {
                          return Stack(
                            children: [
                              state.productFollowShop != null
                                  ? Column(
                                      children: state.productFollowShop!
                                          .map((listProductsFollowShop) {
                                        return ShopWidget(
                                          shop: listProductsFollowShop,
                                          onTapToViewMoreButton: () =>
                                              onTapToViewmoreButton(
                                                  listProductsFollowShop),
                                          onTapToProduct: (productId) =>
                                              onTapToProduct(productId,
                                                  listProductsFollowShop),
                                          onLoading: () {
                                            context
                                                .read<MarketplaceCubit>()
                                                .emitToLoading();
                                          },
                                          unLoading: () {
                                            context
                                                .read<MarketplaceCubit>()
                                                .emitToUnloading();
                                          },
                                        );
                                      }).toList(),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isLoading)
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

  void onTapToViewmoreButton(
      MarketplaceProductFollowShopModel listProductsFollowShop) {
    var user = Storage.user;

    if (user != null) {
      if (user.id == listProductsFollowShop.account.id) {
        //push to current user profile page
        context.router.push(const PersonalProfileRoute());
      } else {
        //push to seller profile page
        context.router.push(ShopProfileRoute(
            shopName: listProductsFollowShop.account.name,
            shopId: listProductsFollowShop.account.id));
      }
    } else {
      //push to seller profile page
      context.router.push(ShopProfileRoute(
          shopName: listProductsFollowShop.account.name,
          shopId: listProductsFollowShop.account.id));
    }
  }

  void onTapToProduct(
      int productId, MarketplaceProductFollowShopModel listProductsFollowShop) {
    var user = Storage.user;

    if (user != null) {
      if (user.id == listProductsFollowShop.account.id) {
        //push to edit post if product belongs to current user
        context.router.push(
            ViewPostRoute(productId: productId, enableToUpdatePost: true, navigationToManagementPostIndex: 1));
      } else {
        //push to buy page if product belongs to other users
        context.router.push(ProductRoute(productId: productId));
      }
    } else {
      //push to buy page if product belongs to other users
      context.router.push(ProductRoute(productId: productId));
    }
  }
}
