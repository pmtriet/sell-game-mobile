import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../app/app_router.dart';
import '../../../shop_profile/presentation/page/shop_profile_page.dart';
import '../../application/post_delete_cubit/post_delete_cubit.dart';
import '../../application/post_pending_cubit/post_pending_cubit.dart';
import '../../application/post_public_cubit/post_public_cubit.dart';
import '../../application/post_reject_cubit/post_reject_cubit.dart';
import '../../application/post_sold_cubit/post_sold_cubit.dart';
import '../../application/tabbar_cubit/tabbar_cubit.dart';
import '../../domain/interface/management_post_repository_interface.dart';

part '../widgets/management_post_body.dart';
part '../widgets/scrollview_tabbar_widget.dart';
part '../component/tabbar_widget.dart';

@RoutePage()
class ManagementPostPage extends StatelessWidget {
  final int? navigatingIndex;
  const ManagementPostPage({super.key, this.navigatingIndex});

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
          titleSpacing: 0,
          title: Text(
            context.s.post_management.toUpperCase(),
            style: context.textTheme.caption,
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorName.background,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: ColorName.background,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TabbarCubit(
                  getIt<IManagementPostRepository>(), navigatingIndex),
            ),
            BlocProvider(
              create: (context) =>
                  PostDeleteCubit(getIt<IManagementPostRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  PostPendingCubit(getIt<IManagementPostRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  PostPublicCubit(getIt<IManagementPostRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  PostRejectCubit(getIt<IManagementPostRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  PostSoldCubit(getIt<IManagementPostRepository>()),
            ),
          ],
          child: const ManagementPostBody(),
        ),
      ),
    );
  }
}
