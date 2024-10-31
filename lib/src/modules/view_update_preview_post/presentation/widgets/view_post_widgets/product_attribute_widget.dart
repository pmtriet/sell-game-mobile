part of '../../page/view_post_page.dart';

class ProductAttributeWidget extends StatelessWidget {
  final List<ProductAttributeModel> attributes;
  final String rank;

  const ProductAttributeWidget({
    super.key,
    required this.attributes,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        context.s.detail_info,
        style: context.textTheme.displaySmall
            .copyWith(color: ColorName.whiteF1F1F1),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
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
              ...attributes.map((attribute) {
                return SizedBox(
                  width: (MediaQuery.sizeOf(context).width -
                          UIConstants.padding * 3) /
                      3,
                  child: _buildInfoColumn(
                    context,
                    attribute.title,
                    attribute.value,
                  ),
                );
              }),
              rank.isNotEmpty
                  ? SizedBox(
                      width: (MediaQuery.sizeOf(context).width -
                              UIConstants.padding * 3) /
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
