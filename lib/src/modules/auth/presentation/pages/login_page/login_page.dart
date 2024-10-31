import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../generated/assets.gen.dart';
import '../../../../../../generated/colors.gen.dart';
import '../../../../../common/dialogs/app_dialogs.dart';
import '../../../../../common/extensions/build_context_x.dart';
import '../../../../../common/utils/getit_utils.dart';
import '../../../../app/app_router.dart';
import '../../../../register/presentation/page/register_page.dart';
import '../../../application/cubit/auth_cubit.dart';
import '../../../domain/request_models/login_request_models/login_request.dart';
import '../../../../../common/widgets/button_widget.dart';
import '../../components/password_module.dart';
import '../../components/textfield_module.dart';
import '../../components/textspan_module.dart';

part '../../widgets/login_widgets/login_body.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //tap outside to hide keyboard
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider.value(
        value: getIt<AuthCubit>(),
        child: LoginBody(),
      ),
    );
  }
}
