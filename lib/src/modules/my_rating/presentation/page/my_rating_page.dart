import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/text_painter_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../app/app_router.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../management_post/presentation/page/management_post_page.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../../transaction_history/presentation/components/star_widget.dart';
import '../../application/buyer_rating_cubit/buyer_rating_cubit.dart';
import '../../application/no_rating_yet_cubit/no_rating_yet_cubit.dart';
import '../../application/rated_cubit/rated_cubit.dart';
import '../../application/tabbar_cubit/tabbar_cubit.dart';
import '../../infrastructure/domain/interface/my_rating_repository_interface.dart';
import '../../infrastructure/models/buyer_rating_model.dart';
import '../../infrastructure/models/no_rating_model.dart';
import '../../infrastructure/models/rated_model.dart';

part '../widgets/my_rating_body.dart';
part '../widgets/tabbar_widget.dart';
part '../widgets/listview_not_rating_yet_orders_widget.dart';
part '../component/rating_product_widget.dart';
part '../widgets/listview_rated_order_widget.dart';
part '../component/rated_product_widget.dart';
part '../component/order_widget.dart';
part '../widgets/listview_buyer_rating_widget.dart';
part '../component/buyer_rated_widget.dart';

@RoutePage()
class MyRatingPage extends StatelessWidget {
  const MyRatingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: context.router.maybePop,
              icon: const Icon(
                Icons.arrow_back,
                color: ColorName.primary,
              )),
          title: Text(
            context.s.my_review.toUpperCase(),
            style:
                context.textTheme.caption.copyWith(color: ColorName.greyBBBBBB),
          ),
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorName.background,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: ColorName.background,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TabbarCubit(),
            ),
            BlocProvider(
              create: (context) =>
                  NoRatingYetCubit(getIt<IMyRatingRepository>()),
            ),
            BlocProvider(
              create: (context) => RatedCubit(getIt<IMyRatingRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  BuyerRatingCubit(getIt<IMyRatingRepository>()),
            ),
          ],
          child: const MyRatingBody(),
        ),
      ),
    );
  }
}
