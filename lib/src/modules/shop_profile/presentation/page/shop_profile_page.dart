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
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../../personal_profile/presentation/components/stats_widget.dart';
import '../../../transaction_history/presentation/components/tab_item_widget.dart';
import '../../application/selling_products_cubit/selling_products_cubit.dart';
import '../../application/shop_profile_cubit/shop_profile_cubit.dart';
import '../../application/sold_products_cubit/sold_products_cubit.dart';
import '../../application/tabbar_cubit/tabbar_cubit.dart';
import '../../domain/interface/shop_profile_repository_interface.dart';
import '../../infrastructure/models/shop_account_model.dart';

part '../widgets/shop_profile_body.dart';
part '../widgets/selling_products_widget.dart';
part '../widgets/sold_products_widget.dart';
part '../widgets/shop_infor_widget.dart';
part '../widgets/follow_button_widget.dart';
part '../widgets/shop_stats_widget.dart';
part '../component/shop_product_widget.dart';

@RoutePage()
class ShopProfilePage extends StatelessWidget {
  final String shopName;
  final int shopId;
  const ShopProfilePage(
      {super.key, required this.shopName, required this.shopId});

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
            shopName.toUpperCase(),
            style: context.textTheme.caption,
          ),
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorName.background,
        ),
        backgroundColor: ColorName.background,
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: getIt<AuthCubit>(),
            ),
            BlocProvider(
              create: (context) =>
                  ShopProfileCubit(getIt<IShopProfileRepository>(), shopId),
            ),
            BlocProvider(
              create: (context) => TabbarCubit(),
            ),
            BlocProvider(
              create: (context) =>
                  SellingProductsCubit(getIt<IShopProfileRepository>(), shopId),
            ),
            BlocProvider(
              create: (context) =>
                  SoldProductsCubit(getIt<IShopProfileRepository>(), shopId),
            ),
          ],
          child: const ShopProfileBody(),
        ),
      ),
    );
  }
}
