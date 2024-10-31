part of '../pages/product_page.dart';

class ListSuggestProductsWidget extends StatelessWidget {
  const ListSuggestProductsWidget({
    super.key,
    required this.suggestProducts, required this.onLoading, required this.unLoading,
  });
  final SuggestProductModel suggestProducts; 
  final VoidCallback onLoading;
  final VoidCallback unLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text(
            context.s.suggest_for_you.toUpperCase(),
            style: context.textTheme.titleSmall,
          ),
          //line
          Padding(
            padding: EdgeInsets.only(bottom: 10.w),
            child: const Divider(
              color: ColorName.grey353535,
              thickness: 1,
            ),
          ),
          //list products
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 173 / 245,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.w,
              ),
              itemCount: suggestProducts.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.router.push(ProductRoute(
                        productId: suggestProducts.data[index].id));
                  },
                  child: ProductCardWidget(
                    product: suggestProducts.data[index], 
                    onLoading: () => onLoading(), 
                    unLoading: () => unLoading(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
