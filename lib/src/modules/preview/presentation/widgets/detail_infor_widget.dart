import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';

class DetailInforsWidget extends StatelessWidget {
  final List<CategoryAttributeModel> attributes;
  final String? rank;

  const DetailInforsWidget({
    super.key,
    required this.attributes,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(
            top: UIConstants.padding,
            bottom: UIConstants.padding,
            left: UIConstants.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(color: ColorName.grey353535, width: 2),
        ),
        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          children: [
            ...attributes.map((attribute) {
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
            rank != null && rank!.isNotEmpty
                ? SizedBox(
                    width: (MediaQuery.sizeOf(context).width -
                            UIConstants.padding * 4) /
                        3,
                    child: _buildInfoColumn(
                      context,
                      context.s.rank,
                      rank!,
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
            style: context.textTheme.contentSmall
                .copyWith(color: ColorName.primary),
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
