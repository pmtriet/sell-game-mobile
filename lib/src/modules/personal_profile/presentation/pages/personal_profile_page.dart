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
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../shop_profile/infrastructure/models/shop_account_model.dart';
import '../../../shop_profile/presentation/page/shop_profile_page.dart';
import '../../application/personal_profile_cubit/personal_profile_cubit.dart';
import '../../application/product_selling_cubit/product_selling_cubit.dart';
import '../../application/product_sold_cubit/product_sold_cubit.dart';
import '../../application/tabbar_cubit/tabbar_cubit.dart';
import '../../domain/interface/personal_profile_repository_interface.dart';
import '../components/stats_widget.dart';

part '../widgets/personal_profile_body.dart';
part '../widgets/base_infor_widget.dart';
part '../widgets/shop_stats_widget.dart';
part '../widgets/tabbar_widget.dart';
part '../components/tab_item_widget.dart';

@RoutePage()
class PersonalProfilePage extends StatelessWidget {
  const PersonalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              PersonalProfileCubit(getIt<IPersonalProfileRepository>()),
        ),
        BlocProvider(
          create: (context) => TabbarCubit(getIt<IPersonalProfileRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              ProductSellingCubit(getIt<IPersonalProfileRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              ProductSoldCubit(getIt<IPersonalProfileRepository>()),
        ),
      ],
      child: const PersonalProfileBody(),
    ));
  }
}
