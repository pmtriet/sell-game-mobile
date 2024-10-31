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
import '../../../../common/toasts/app_toasts.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../app/app_router.dart';
import '../../../post/domain/interface/post_repository_interface.dart';
import '../../../post/presentation/components/post_button_widget.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../../application/cubit/preview_cubit.dart';
import '../../infrastructure/model/post_model.dart';
import '../widgets/detail_infor_widget.dart';

part '../widgets/preview_body.dart';

@RoutePage()
class PreviewPage extends StatelessWidget {
  const PreviewPage(
      {super.key,
      required this.post,
      required this.username,
      required this.avatar});
  final PostModel post;
  final String username;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PreviewCubit>(
          create: (_) => PreviewCubit(getIt<IPostRepository>()),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: context.router.maybePop,
                icon: const Icon(
                  Icons.arrow_back,
                  color: ColorName.primary,
                )),
            titleSpacing: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorName.background,
          ),
          backgroundColor: ColorName.background,
          body: PreviewBody(
            username: username,
            avatar: avatar,
            post: post,
          ),
        ),
      ),
    );
  }
}
