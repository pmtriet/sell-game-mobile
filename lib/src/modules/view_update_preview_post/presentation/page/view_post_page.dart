import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/int_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/toasts/app_toasts.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../app/app_router.dart';
import '../../../home/infrastructure/models/category_product_models/product_attribute_model.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../../post/presentation/components/post_button_widget.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../../application/view_post_cubit/view_post_cubit.dart';
import '../../domain/interface/view_post_repository_interface.dart';
part '../widgets/view_post_widgets/view_post_body.dart';
part '../widgets/view_post_widgets/product_attribute_widget.dart';
part '../widgets/view_post_widgets/account_product_widget.dart';

@RoutePage()
class ViewPostPage extends StatelessWidget {
  final int productId;
  final bool enableToUpdatePost;
  final int? navigationToManagementPostIndex;
  const ViewPostPage(
      {super.key,
      required this.productId,
      required this.enableToUpdatePost,
      this.navigationToManagementPostIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: ColorName.background,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                  color: ColorName.primary,
                ),
                onPressed: () {
                  context.router.maybePop();
                },
              ),
            ),
            backgroundColor: ColorName.background,
            body: BlocProvider(
              create: (context) =>
                  ViewPostCubit(productId, getIt<IViewPostRepository>()),
              child: ViewPostBody(
                  enableToUpdatePost: enableToUpdatePost,
                  navigationToManagementPostIndex:
                      navigationToManagementPostIndex),
            )));
  }
}
