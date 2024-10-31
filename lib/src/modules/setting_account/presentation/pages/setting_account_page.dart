import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../edition_infor/presentation/pages/edition_page.dart';
import '../../../personal_profile_edit/application/cubit/personalprofile_edit_cubit.dart';
import '../../application/display_change_password_cubit/display_change_password_cubit.dart';
import '../../application/setting_account_cubit/setting_account_cubit.dart';
import '../../domain/interface/setting_account_repository_interface.dart';

import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../personal_profile_edit/presentation/widgets/personalprofile_edit_infor_widget.dart';
part '../widgets/setting_account_body.dart';
part '../widgets/change_password_widget.dart';
part '../components/button_widget.dart';
part '../components/row_widget.dart';
part '../components/textfield_widget.dart';
part '../components/two_text_row_widget.dart';

@RoutePage()
class SettingAccountPage extends StatelessWidget {
  const SettingAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PersonalprofileEditCubit>(),
        ),
        BlocProvider(
          create: (context) => DisplayChangePasswordCubit(),
        ),
        BlocProvider(
          create: (context) =>
              SettingAccountCubit(getIt<ISettingAccountRepository>()),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditionPage(
          title: context.s.account_setting,
          body: const SettingAccountBody(),
        ),
      ),
    );
  }
}
