import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../app/app_router.dart';
import '../../../home/domain/entities/category.dart';
import '../../application/categories_all_cubit/categories_all_cubit.dart';

part '../widget/categories_all_body.dart';
part '../widget/gridview_categories_widget.dart';
part '../components/category_card_widget.dart';

@RoutePage()
class CategoriesAllPage extends StatelessWidget {
  const CategoriesAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesAllCubit>(),
      child: const CategoriesAllBody(),
    );
  }
}
