part of '../pages/product_page.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductModel product;

  late final String title =
      product.attributes.map((e) => '${e.title} ${e.value}').join(' | ');
  late final String rank = product.rank;

  ProductDetailsWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        context.s.detail_info,
        style: context.textTheme.displaySmall
            .copyWith(color: ColorName.whiteF1F1F1),
      ),
      SizedBox(height: 20.h),
      Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(
            top: UIConstants.padding,
            bottom: UIConstants.padding,
            left: UIConstants.padding),
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          children: [
            ...product.attributes.map((attribute) {
              return SizedBox(
                width: (MediaQuery.sizeOf(context).width -
                        UIConstants.padding * 4) /
                    3,
                child: _buildInfoColumn(
                  context,
                  attribute.title,
                  attribute.value,
                ),
              );
            }),
            // ignore: unnecessary_null_comparison
            rank != null && rank.isNotEmpty
                ? SizedBox(
                    width: (MediaQuery.sizeOf(context).width -
                            UIConstants.padding * 4) /
                        3,
                    child: _buildInfoColumn(
                      context,
                      context.s.rank,
                      rank,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    ]);
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: UIConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.contentSmall,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.captionLarge,
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
