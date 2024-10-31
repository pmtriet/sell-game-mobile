import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../../common/widgets/edition_textfield_widget.dart';
import '../../../app/app_router.dart';
import '../../application/name_edition_cubit/name_edition_cubit.dart';
import 'edition_page.dart';
part '../widgets/name_edition_body.dart';

@RoutePage()
class NameEditionPage extends StatelessWidget {
  const NameEditionPage({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NameEditionCubit>(),
      child: EditionPage(
        title: context.s.username,
        body: NameEditionBody(name: name),
      ),
    );
  }
}