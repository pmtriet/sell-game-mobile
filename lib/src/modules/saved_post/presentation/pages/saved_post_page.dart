import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/int_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../application/saved_post_cubit.dart';
import '../../domain/interface/saved_post_repository_interface.dart';
import '../../infrastructure/model/saved_post_model.dart';

part '../widgets/saved_post_body.dart';
part '../component/saved_post_widget.dart';
part '../widgets/listview_saved_post_widget.dart';

@RoutePage()
class SavedPostPage extends StatelessWidget {
  const SavedPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: ColorName.green3BD9AC,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              context.s.saved_post.toUpperCase(),
              style: context.textTheme.displayLarge
                  .copyWith(color: ColorName.greyBBBBBB),
            ),
          ),
          titleTextStyle: const TextStyle(),
        ),
        backgroundColor: ColorName.background,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  SavedPostCubit(getIt<ISavedPostRepository>()),
            ),
            BlocProvider.value(
              value: getIt<AuthCubit>(),
            ),
          ],
          child: const SavedPostBody(),
        ),
      ),
    );
  }
}
