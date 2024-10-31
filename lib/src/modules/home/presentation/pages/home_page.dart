import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../common/widgets/login_text_widget.dart';
import '../../../../common/widgets/search_bar_widget.dart';
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/user.dart';
import '../../application/cubit/home_cubit.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/category.dart';
import '../card_widgets/product_card_widget.dart';


part '../widgets/home_body.dart';
part '../widgets/banner_slider_widget.dart';
part '../widgets/game_category_widget.dart';
part '../widgets/hightlight_widget.dart';
part '../widgets/user_infor_widget.dart';
part '../card_widgets/banner_card_widget.dart';
part '../card_widgets/game_card_showmore_widget.dart';
part '../card_widgets/game_card_widget.dart';
part '../card_widgets/hightlight_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<HomeCubit>(),
        ),
      ],
      child: const Scaffold(
          backgroundColor: ColorName.background, body: HomeBody()),
    ));
  }
}
