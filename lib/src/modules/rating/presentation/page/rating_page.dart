import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../app/app_router.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../transaction_history/presentation/components/tab_item_widget.dart';
import '../../application/cubit/rating_cubit.dart';
import '../../domain/interface/rating_repository_interface.dart';
part '../widgets/rating_body.dart';
part '../widgets/tabbar_widget.dart';
part '../widgets/order_widget.dart';
part '../widgets/rating_star_widget.dart';
part '../widgets/remark_textfield_widget.dart';

@RoutePage()
class RatingPage extends StatelessWidget {
  final int id;
  final int value;
  final String code;
  final List<ProductImageModel> images;
  final String title;
  final PageRouteInfo<dynamic>? popRoute;
  const RatingPage({
    super.key,
    required this.id,
    required this.value,
    required this.code,
    required this.images,
    required this.title, 
    this.popRoute,
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
            context.s.rating_seller.toUpperCase(),
            style: context.textTheme.caption,
          ),
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorName.background,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: ColorName.background,
        body: BlocProvider(
          create: (context) => RatingCubit(id, getIt<IRatingRepository>()),
          child: RatingBody(
            value: value,
            code: code,
            images: images,
            title: title,
            popRoute: popRoute
          ),
        ),
      ),
    );
  }
}
