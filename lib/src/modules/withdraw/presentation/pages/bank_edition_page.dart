import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../application/bank_edition_cubit/bank_edition_cubit.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../infrastructure/models/bank_account_model.dart';
import '../components/bank_item_widget.dart';
import '../components/withdraw_textfield_widget.dart';
import '../pages/bank_search_page.dart';

part '../widgets/bank_edition_body.dart';

@RoutePage()
class BankEditionPage extends StatelessWidget {
  const BankEditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: getIt<BankEditionCubit>(),
          ),
      ],
      child: const BankEditionBody(),
      
    );
  }
}
