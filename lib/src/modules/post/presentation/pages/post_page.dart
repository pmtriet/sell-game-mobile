import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/toasts/app_toasts.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../app/app_router.dart';
import '../../../home/domain/entities/category.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../../home/infrastructure/models/category_models/category_model.dart';
import '../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';
import '../../../preview/infrastructure/model/post_model.dart';
import '../components/account_game_textfield_widget.dart';
import '../components/image_widget.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/image_utils.dart';
import '../../../home/domain/interfaces/home_repository_interface.dart';
import '../../applications/add_image_cubit/add_image_cubit.dart';
import '../../applications/attributes_cubit/attributes_cubit.dart';
import '../../applications/game_cubit/game_cubit.dart';
import '../../applications/post_cubit/post_cubit.dart';
import '../../applications/ranks_cubit/ranks_cubit.dart';
import '../../applications/sign_in_methods_cubit/sign_in_methods_cubit.dart';
import '../../domain/interface/post_repository_interface.dart';
import '../components/add_image_mini_widget.dart';
import '../components/post_button_widget.dart';
import '../widgets/detail_description_textfield_widget.dart';
import '../widgets/price_textfield_widget.dart';
import '../widgets/select_type_item_widget.dart';
import '../widgets/title_textfield_widget.dart';

part '../widgets/add_images_widget.dart';
part '../widgets/category_dropdown_widget.dart';
part '../widgets/rank_dropdown_row_widget.dart';
part '../widgets/signin_method_dropdown_row_widget.dart';
part '../widgets/post_body.dart';

@RoutePage()
class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostCubit(getIt<IPostRepository>()),
        ),
        BlocProvider(
          create: (context) => GameCubit(getIt<IHomeRepository>()),
        ),
        BlocProvider(
          create: (context) => AttributesCubit(),
        ),
        BlocProvider(
          create: (context) => SignInMethodsCubit(),
        ),
        BlocProvider(
          create: (context) => RanksCubit(),
        ),
        BlocProvider(
          create: (context) => AddImageCubit(),
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
            title: Text(
              context.s.post.toUpperCase(),
              style: context.textTheme.displayLarge,
            ),
            titleSpacing: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorName.background,
          ),
          backgroundColor: ColorName.background,
          body: const PostBody(),
        ),
      ),
    );
  }
}
