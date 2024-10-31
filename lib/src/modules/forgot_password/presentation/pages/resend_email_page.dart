import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../auth/presentation/pages/login_page/login_page.dart';
import '../../application/counter_cubit/counter_cubit.dart';
import '../../application/resend_email_cubit/resend_email_cubit.dart';
import '../../domain/forgot_password_repository_interface.dart';

part '../widgets/resend_email_body.dart';

@RoutePage()
class ResendEmailPage extends StatelessWidget {
  final String email;
  const ResendEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ResendEmailCubit(getIt<IForgotPasswordRepository>()),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
      ],
      child: ResendEmailBody(
        email: email,
      ),
    ));
  }
}
