import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/formatter/money_formatter.dart';
import '../../../../common/formatter/only_digit_formatter.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/gridview_products_widget.dart';
import '../../../../common/widgets/search_bar_widget.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../home/domain/entities/category.dart';
import '../../application/category_cubit/category_cubit.dart';
import '../../application/filter_cubit/filter_price_cubit/filter_price_cubit.dart';
import '../../application/filter_cubit/filter_option_cubit/filter_option_cubit.dart';
import '../../application/filter_cubit/ranks_filter_cubit/ranks_filter_cubit.dart';
import '../../domain/entity/filter_result.dart';
import '../../domain/interface/category_repository_interface.dart';
import '../../infrastructure/models/filter_price_rank_model.dart';
import '../modules/option_filter_module.dart';

part '../widgets/category_body.dart';
part '../widgets/category_header_widget.dart';
part '../widgets/menu_filters_wiget.dart';
part '../modules/filter_module.dart';
part '../modules/filter_side_sheet_widget.dart';
part '../modules/price_filter_module.dart';
part '../filter_components/filter_button_widget.dart';
part '../filter_components/gridview_ranks_widget.dart';
part '../filter_components/price_textfield_widget.dart';
part '../filter_components/rank_widget.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColorName.background,
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) =>
                      CategoryCubit(category, getIt<ICategoryRepository>())),
              BlocProvider(create: (_) => FilterOptionCubit()),
              BlocProvider(create: (_) => FilterPriceCubit()),
              BlocProvider(create: (_) => RanksFilterCubit(category.ranks)),
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
            ],
            child: CategoryBody(
              category: category,
            ),
          ),
        ),
      ),
    );
  }
}
