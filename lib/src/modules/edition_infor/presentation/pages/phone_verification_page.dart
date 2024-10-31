import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../../common/widgets/edition_textfield_widget.dart';
import '../../../app/app_router.dart';
import '../../application/counting_textfield_cubit/counting_textfield_cubit.dart';
import '../../application/phone_verification_cubit/phone_verification_cubit.dart';
part '../widgets/phone_verification_body.dart';

@RoutePage()
class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PhoneVerificationCubit(),
        ),
        BlocProvider(
          create: (context) => CountingTextfieldCubit(),
        ),
      ],
      child: SafeArea(
        child: PhoneVerificationBody(
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }
}
