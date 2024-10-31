import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../post/presentation/components/post_button_widget.dart';
import '../../../preview/infrastructure/model/post_model.dart';
import '../../../preview/presentation/widgets/detail_infor_widget.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../../application/preview_post_cubit/preview_post_cubit.dart';
import '../../domain/interface/update_post_repository_interface.dart';
import '../../infrastructure/models/user_product_model.dart';

part '../widgets/preview_post_widgets/preview_post_body.dart';

@RoutePage()
class PreviewPostPage extends StatelessWidget {
  const PreviewPostPage(
      {super.key,
      required this.post,
      required this.username,
      required this.avatar,
      required this.selectedRemainingImages,
      required this.deletedImages,
      required this.previousPost});
  final PostModel post;
  final UserProductModel previousPost;
  final List<ProductImageModel>? selectedRemainingImages;
  final List<String>? deletedImages;
  final String username;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PreviewPostCubit>(
          create: (_) => PreviewPostCubit(getIt<IUpdatePostRepository>()),
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
              titleSpacing: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: ColorName.background,
            ),
            backgroundColor: ColorName.background,
            body: PreviewPostBody(
              username: username,
              avatar: avatar,
              post: post,
              previousPost: previousPost, 
              selectedRemainingImages: selectedRemainingImages, 
              deletedImages: deletedImages,
            ),
          ),
        ),
      ),
    );
  }
}
