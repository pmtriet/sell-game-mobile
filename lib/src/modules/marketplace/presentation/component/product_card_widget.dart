part of '../page/marketplace_page.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget(
      {super.key,
      required this.product,
      required this.onLoading,
      required this.unLoading});
  final MarketplaceProductModel product;
  final VoidCallback onLoading;
  final VoidCallback unLoading;

  @override
  State<ProductCardWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    var formattedPrice = (widget.product.price).toNumberFormat();
    var isFavourited = FavouriteProductsUntil.isFavourite(widget.product.id);

    Future<void> onTapFavourite() async {
      if (isFavourited) {
        //liked -> unlike
        widget.onLoading();

        final result =
            await getIt<AuthCubit>().deleteFavouriteProduct(widget.product.id);

        widget.unLoading();

        if (result) {
          setState(() {
            isFavourited = false;
          });
        } else {
          AppDialogs.show(content: S.current.error_unexpected);
        }
      } else {
        //unliked -> like
        widget.onLoading();

        final result =
            await getIt<AuthCubit>().setFavouriteProduct(widget.product.id);

        widget.unLoading();

        if (result) {
          setState(() {
            isFavourited = true;
          });
        } else {
          AppDialogs.show(content: S.current.error_unexpected);
        }
      }
    }

    return SizedBox(
      width: 173.w,
      height: 234.w,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorName.black1E1E1E,
                  borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                  border: Border.all(color: ColorName.grey353535)),
            ),
          ),
          Positioned.fill(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: SizedBox(
                    width: 157.w,
                    height: 120.h,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(UIConstants.imgRadius),
                          child: widget.product.images.isNotEmpty
                              ? CacheImageWidget(
                                  url: widget.product.images[0].filePath,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: ColorName.black1E1E1E,
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                        )),
                        //discount
                        if (widget.product.saleOff != 0)
                          Container(
                            decoration: const BoxDecoration(
                                color: ColorName.green3BD9AC,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Sale ',
                                    style: context.textTheme.bodySmall
                                        .copyWith(color: ColorName.black),
                                  ),
                                  TextSpan(
                                    text: (widget.product.saleOff * 100)
                                        .toPercent(),
                                    style: context.textTheme.headlineMedium
                                        .copyWith(color: ColorName.black),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        //favourite
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () => state.maybeWhen(
                                    authenticated: (_) => onTapFavourite(),
                                    orElse: () => AppDialogs.show(
                                          type: AlertType.notice,
                                          content: context.s.login_please,
                                          action1: () => context.router
                                              .push(const AuthRoute()),
                                        )),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                  child: isFavourited
                                      ? const Icon(Icons.star,
                                          color: ColorName.whiteF1F1F1)
                                      : const Icon(Icons.star_border,
                                          color: ColorName.whiteF1F1F1),
                                ),
                              ),
                            );
                          },
                        ),

                        Positioned.fill(
                          top: 40,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                  ColorName.green3BD9AC.withOpacity(0.7),
                                  Colors.transparent
                                ])),
                          ),
                        ),
                        //id product
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: Text(
                              'ID: ${widget.product.code}',
                              style: context.textTheme.headlineMedium
                                  .copyWith(fontSize: 12)
                                  .copyWith(color: ColorName.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //title
                Text(
                  widget.product.title,
                  style: context.textTheme.contentSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                //createdTime and categoryName
                Padding(
                  padding: EdgeInsets.only(top: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //icon time
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Icon(
                          Icons.access_time,
                          color: ColorName.grey787878,
                          size: 12.w,
                        ),
                      ),
                      //created time
                      Text(
                        widget.product.updatedAt.toDurationFormat(),
                        style: context.textTheme.labelSmall,
                      ),
                      //icon dot
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Icon(
                          Icons.circle,
                          color: ColorName.grey787878,
                          size: 2.w,
                        ),
                      ),
                      //category name
                      Expanded(
                        child: Text(
                          widget.product.category.name,
                          style: context.textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                //price
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '$formattedPrice${context.s.currency_unit}',
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
