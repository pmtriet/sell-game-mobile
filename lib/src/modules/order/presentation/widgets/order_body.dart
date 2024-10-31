import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../app/app_router.dart';
import '../../../../common/extensions/build_context_x.dart';
import 'order_widget.dart';

class OrderBody extends StatelessWidget {
  OrderBody({
    super.key,
  });

  final List<Map<String, dynamic>> productList = [
    {
      'imagePath': 'assets/images/home_default_img_slider.webp',
      'title': 'Tướng 167 | Trang phục 208 | Linh thú 3',
      'gameName': 'Liên Quân',
      'price': '700.000đ',
      'timeOrder': DateTime.now(),
    },
    {
      'imagePath': 'assets/images/home_default_img_slider.webp',
      'title': 'Tướng 168 | Trang phục 209',
      'gameName': 'Liên Quân',
      'price': '800.000đ',
      'timeOrder': DateTime.now(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: ColorName.green3BD9AC,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.chat_bubble_outline_sharp,
                size: 20.sp,
                color: ColorName.whiteF1F1F1,
              ),
              onPressed: () {}),
        ],
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            context.s.purchase_order.toUpperCase(),
            style: context.textTheme.displayLarge,
          ),
        ),
        titleTextStyle: const TextStyle(),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final product = productList[index];
            return GestureDetector(
              onTap: () {
                context.router.push(InfoOrderRoute(orderId: 1));
              },
              child: OrderWidget(
                imagePath: product['imagePath'],
                title: product['title'],
                gameName: product['gameName'],
                price: product['price'],
                timeOrder: product['timeOrder'],
              ),
            );
          },
        ),
      ),
    );
  }
}
