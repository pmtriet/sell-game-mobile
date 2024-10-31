import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/double_x.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../buy/infrastructor/models/category_product.dart';

class SearchProductCardWidget extends StatelessWidget {
  const SearchProductCardWidget({super.key, required this.modelProducts});

  final ProductModel modelProducts;

  @override
  Widget build(BuildContext context) {
    var formattedPrice = (modelProducts.price).toNumberFormat();
    return SizedBox(
      width: 173.w,
      height: 228.w,
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
                          child: modelProducts.images.isNotEmpty
                              ? modelProducts.images[0].filePath.isNotEmpty
                                  ? CacheImageWidget(
                                      url: modelProducts.images[0].filePath,
                                      fit: BoxFit.cover,
                                    )
                                  : Assets.icons.deletedImage.svg()
                              : Assets.icons.deletedImage.svg(),
                        )),
                        //discount
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
                                  text:
                                      (modelProducts.saleOff * 100).toPercent(),
                                  style: context.textTheme.headlineMedium
                                      .copyWith(color: ColorName.black),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        //favourite
                        const Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                            child: Icon(Icons.star_border,
                                color: ColorName.whiteF1F1F1),
                          ),
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
                              'ID: ${modelProducts.code}',
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
                //description
                Text(
                  modelProducts.title,
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
                        modelProducts.createdAt.toDurationFormat(),
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
                          modelProducts.category.name,
                          style: context.textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                //price
                Text(
                  '$formattedPrice${context.s.currency_unit}',
                  style: context.textTheme.labelMedium,
                ),
                const SizedBox(
                  height: UIConstants.padding,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
