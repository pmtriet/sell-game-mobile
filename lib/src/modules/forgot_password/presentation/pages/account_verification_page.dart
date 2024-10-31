import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../app/app_router.dart';
import '../../application/account_verification_cubit/account_verification_cubit.dart';
import '../../domain/forgot_password_repository_interface.dart';
part '../widgets/account_verification_body.dart';

@RoutePage()
class AccountVerificationPage extends StatelessWidget {
  const AccountVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) =>
            AccountVerificationCubit(getIt<IForgotPasswordRepository>()),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: context.router.maybePop,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: ColorName.primary,
                      )),
                  title: Text(
                    context.s.verify_account.toUpperCase(),
                    style: context.textTheme.headlineSmall,
                  ),
                  titleSpacing: 0,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: ColorName.background,
                ),
                backgroundColor: ColorName.background,
                body: const AccountVerificationBody())),
      ),
    );
  }
}
