
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/toasts/app_toasts.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/image_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../app/app_router.dart';
import '../../../home/domain/interfaces/home_repository_interface.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../../home/infrastructure/models/category_models/category_model.dart';
import '../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../post/presentation/components/account_game_textfield_widget.dart';
import '../../../post/presentation/components/add_image_mini_widget.dart';
import '../../../post/presentation/components/image_widget.dart';
import '../../../post/presentation/components/post_button_widget.dart';
import '../../../post/presentation/widgets/detail_description_textfield_widget.dart';
import '../../../post/presentation/widgets/price_textfield_widget.dart';
import '../../../post/presentation/widgets/select_type_item_widget.dart';
import '../../../post/presentation/widgets/title_textfield_widget.dart';
import '../../../preview/infrastructure/model/post_model.dart';
import '../../application/update_post_cubit/add_image_cubit/add_image_cubit.dart';
import '../../application/update_post_cubit/attribute_cubit/attribute_cubit.dart';
import '../../application/update_post_cubit/category_game_cubit/category_game_cubit.dart';
import '../../application/update_post_cubit/rank_cubit/rank_cubit.dart';
import '../../application/update_post_cubit/sign_in_method_cubit/sign_in_method_cubit.dart';
import '../../application/update_post_cubit/update_post_cubit.dart';
import '../../domain/interface/update_post_repository_interface.dart';
import '../../infrastructure/models/user_product_model.dart';
part '../widgets/update_post_widgets/update_post_body.dart';
part '../widgets/update_post_widgets/category_dropdown_widget.dart';
part '../widgets/update_post_widgets/add_image_widget.dart';
part '../widgets/update_post_widgets/image_filepath_widget.dart';
part '../widgets/update_post_widgets/sign_in_method_dropdown_widget.dart';
part '../widgets/update_post_widgets/rank_dropdown_widget.dart';
@RoutePage()
class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({super.key, required this.post});
  final UserProductModel post;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdatePostCubit(getIt<IUpdatePostRepository>()),
        ),
        BlocProvider(
          create: (context) => CategoryGameCubit(getIt<IHomeRepository>(), post.category.id),
        ),
        BlocProvider(
          create: (context) => AttributeCubit(post.attributes),
        ),
        BlocProvider(
          create: (context) => SignInMethodCubit(post.signInMethod.id),
        ),
        BlocProvider(
          create: (context) => RankCubit(post.rank),
        ),
        BlocProvider(
          create: (context) => AddImageCubit(post.images),
        ),
      ],
      child: SafeArea(
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
                context.s.edit_post.toUpperCase(),
                style: context.textTheme.caption,
              ),
              titleSpacing: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: ColorName.background,
            ),
            backgroundColor: ColorName.background,
            body: UpdatePostBody(previousPost: post,),
          ),
        ),
      ),
    );
  }
}
