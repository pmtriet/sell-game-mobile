import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../app/app_router.dart';
import '../../application/checkbox_cubit/checkbox_cubit.dart';
import '../../application/register_cubit/register_cubit.dart';
import '../../domain/interface/register_repository_interface.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../auth/presentation/components/password_module.dart';
import '../../../auth/presentation/components/textfield_module.dart';
import '../../../auth/presentation/components/textspan_module.dart';
import '../../../auth/presentation/pages/login_page/login_page.dart';
import '../../domain/request_models/register_request.dart';

part '../widget/register_body.dart';
part '../widget/checkbox_row_widget.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //tap outside to hide keyboard
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => RegisterCubit(getIt<IRegisterRepository>()),
            ),
            BlocProvider(
              create: (context) => CheckboxCubit(),
            ),
          ],
          child: RegisterBody(),
        ),
      ),
    );
  }
}
