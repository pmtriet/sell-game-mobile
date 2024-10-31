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
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../common/widgets/login_text_widget.dart';
import '../../../../common/widgets/menu_item_widget.dart';
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';

part '../widgets/profile_body.dart';
part '../widgets/order_management_widget.dart';
part '../widgets/other_widget.dart';
part '../widgets/sell_management_widget.dart';
part '../widgets/utilities_widget.dart';
part '../widgets/budget_widget.dart';
part '../widgets/user_infor_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<AuthCubit>(),
          ),
        ],
        child: const ProfileBody(),
      ),
    );
  }
}
