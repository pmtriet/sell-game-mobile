import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../application/info_order_cubit.dart';
import '../../application/info_order_state.dart';
import '../widgets/info_order_body.dart';

@RoutePage()
class InfoOrderPage extends StatelessWidget {
  final int orderId;
  const InfoOrderPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoOrderCubit(orderId),
      child: Scaffold(
        backgroundColor: ColorName.background,
        appBar: AppBar(
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 16.sp,
              color: ColorName.green3BD9AC,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              context.s.info_order.toUpperCase(),
              style: context.textTheme.displayLarge
                  .copyWith(color: ColorName.whiteF1F1F1),
            ),
          ),
          titleTextStyle: const TextStyle(),
        ),
        body: BlocBuilder<InfoOrderCubit, InfoOrderState>(
          builder: (context, state) {
            return state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (orderInfo) => InfoOrderBody(orderInfo: orderInfo),
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }
}
