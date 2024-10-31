import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../../order_history/infrastucture/model/transaction_model.dart';

class ProductDetailsWidgetInColumn extends StatelessWidget {
  final List<ProductAttribute> attributes;
  final ProductModel? product;
  final TransactionModel? transaction;

  const ProductDetailsWidgetInColumn({
    super.key,
    required this.attributes,
    this.product,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            context.s.detail_info,
            style: context.textTheme.captionSmall,
          ),
        ),
        // Details Container
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorName.background,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: ColorName.grey353535),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column (Labels)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...attributes.map((attribute) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            attribute.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.captionSmall,
                          ),
                        );
                      }),
                      if (product?.rank.isNotEmpty ?? false)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            context.s.rank,
                            style: context.textTheme.captionSmall,
                          ),
                        ),
                      if (transaction?.product.rank.isNotEmpty ?? false)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            context.s.rank,
                            style: context.textTheme.captionSmall,
                          ),
                        ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  width: 1.w,
                  color: ColorName.grey353535,
                ),
                // Right Column (Values)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...attributes.map((attribute) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            attribute.value.isNotEmpty
                                ? attribute.value
                                : 'N/A',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.captionSmall,
                          ),
                        );
                      }),
                      if (product?.rank.isNotEmpty ?? false)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            product!.rank,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.captionSmall,
                          ),
                        ),
                      if (transaction?.product.rank.isNotEmpty ?? false)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            transaction!.product.rank,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.captionSmall,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
