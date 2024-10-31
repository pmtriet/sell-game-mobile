import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../application/bank_edition_cubit/bank_edition_cubit.dart';
import '../../application/bank_search_cubit/bank_search_cubit.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../infrastructure/models/bank_model.dart';
import '../components/searchbar_widget.dart';
import '../widgets/listview_banks_widget.dart';

part '../widgets/bank_search_body.dart';
@RoutePage()
class BankSearchPage extends StatelessWidget {
  const BankSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: getIt<BankEditionCubit>(),
            ),
            BlocProvider(
              create: (context) => BankSearchCubit(),
            ),
          ],
          child: const BankSearchBody(),
        ),
      ),
    );
  }
}
