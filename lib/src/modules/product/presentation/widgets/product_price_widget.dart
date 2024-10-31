part of '../pages/product_page.dart';

class ProductPriceWidget extends StatefulWidget {
  const ProductPriceWidget(
      {super.key,
      required this.price,
      this.discount,
      this.originalPrice,
      required this.productId,
      required this.onLoading,
      required this.unLoading});
  final String price;
  final int productId;
  final VoidCallback onLoading;
  final VoidCallback unLoading;
  final double? discount;
  final String? originalPrice;

  @override
  State<ProductPriceWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductPriceWidget> {
  @override
  Widget build(BuildContext context) {
    var isFavourited = FavouriteProductsUntil.isFavourite(widget.productId);

    Future<void> onTapFavourite() async {
      if (isFavourited) {
        //liked -> unlike
        widget.onLoading();

        final result =
            await getIt<AuthCubit>().deleteFavouriteProduct(widget.productId);

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
            await getIt<AuthCubit>().setFavouriteProduct(widget.productId);
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //price, discount
        Row(
          children: [
            Text(
              widget.price,
              style: context.textTheme.productTitle,
            ),
            if (widget.discount != null &&
                (widget.discount! * 100).toInt() != 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorName.grey353535,
                      borderRadius:
                          BorderRadius.circular(UIConstants.imgRadius)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      ' -${(widget.discount! * 100).toInt()}% ',
                      style:
                          context.textTheme.headingSmall.copyWith(fontSize: 10),
                    ),
                  ),
                ),
              ),
            if (widget.originalPrice != null &&
                (widget.discount! * 100).toInt() != 0)
              Text(
                widget.originalPrice!,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: ColorName.grey8E8E8E,
                  decorationThickness: 2,
                  fontSize: 14,
                  color: ColorName.grey8E8E8E,
                ),
              )
          ],
        ),

        //favourite button
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
                          action1: () => context.router.push(const AuthRoute()),
                        )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  child: isFavourited
                      ? const Icon(Icons.star, color: ColorName.whiteF1F1F1)
                      : const Icon(Icons.star_border,
                          color: ColorName.whiteF1F1F1),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
