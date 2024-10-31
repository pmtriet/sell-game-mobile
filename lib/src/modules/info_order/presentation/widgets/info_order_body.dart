import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/int_x.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../app/app_router.dart';
import '../../../buy/presentation/widgets/product_summary_widget.dart';
import '../../infrastructure/models/info_order_model.dart';
import 'summary_order_widget.dart';
import 'time_order_widget.dart';

class InfoOrderBody extends StatelessWidget {
  final InfoOrderModel orderInfo;
  const InfoOrderBody({
    super.key,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          ProductSummaryWidget(
            imagePath: orderInfo.imagePath,
            title: orderInfo.title,
            gameName: orderInfo.gameName,
            code: orderInfo.productId,
            price: orderInfo.price.toVND(),
          ),
          SizedBox(height: 24.h),
          // ProductDetailsWidget(
          //   title: context.s.detail_info,
          //   details: [
          //     {context.s.heroes: orderInfo.heroes},
          //     {context.s.skins: orderInfo.skins},
          //     {context.s.rank: orderInfo.rank},
          //   ],
          // ),
          SizedBox(height: 24.h),
          SummaryOrderWidget(
            summaryItems: [
              {
                'label': context.s.total_payment,
                'value': orderInfo.totalPayment.toVND(),
              },
              {
                'label': context.s.discount_code,
                'value': orderInfo.discountCode.toInt().toVND(),
              },
              {
                'label': context.s.final_price,
                'value': orderInfo.finalPrice.toVND(),
              },
            ],
            highlightIndex: 2,
          ),
          SizedBox(height: 24.h),
          TimeOrderWidget(
            orderCode: orderInfo.orderCode,
            orderTime: orderInfo.orderTime,
          ),
          const Spacer(),
          ButtonWidget(
            title: context.s.contact.toUpperCase(),
            onTextButtonPressed: () {
              context.router.push(const PersonalProfileRoute());
            },
            backgroundColor: ColorName.background,
            foregroundColor: ColorName.primary,
            borderSideColor: ColorName.primary,
          ),
        ],
      ),
    );
  }
}
