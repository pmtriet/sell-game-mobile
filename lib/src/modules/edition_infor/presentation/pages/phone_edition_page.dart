import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../../common/widgets/edition_textfield_widget.dart';
import '../../../app/app_router.dart';
import '../../application/phone_edition_cubit/phone_edition_cubit.dart';
import 'edition_page.dart';

part '../widgets/phone_edition_body.dart';

@RoutePage()
class PhoneEditionPage extends StatelessWidget {
  const PhoneEditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneEditionCubit(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditionPage(
          title: context.s.phone,
          body: const PhoneEditionBody(),
        ),
      ),
    );
  }
}
