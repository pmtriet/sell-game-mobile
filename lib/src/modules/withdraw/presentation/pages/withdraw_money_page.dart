import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../application/bank_edition_cubit/bank_edition_cubit.dart';
import '../../application/withdraw_money_cubit/withdraw_money_cubit.dart';
import 'withdraw_page.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../app/app_router.dart';
import '../../infrastructure/models/bank_account_model.dart';
import '../components/bank_account_item_widget.dart';
import '../components/withdraw_textfield_widget.dart';
import '../../../../../../generated/assets.gen.dart';

part '../widgets/withdraw_money_body.dart';
part '../widgets/withdraw_money_widgets/adding_bank_account_widget.dart';
part '../widgets/withdraw_money_widgets/available_balance_widget.dart';
part '../widgets/withdraw_money_widgets/withdraw_remaining_number_widget.dart';

@RoutePage()
class WithdrawMoneyPage extends StatelessWidget {
  const WithdrawMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<WithdrawMoneyCubit>(),
          ),
        BlocProvider(
          create: (context) => getIt<BankEditionCubit>(),
        ),
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
      ],
      child: WithdrawPage(
        title: context.s.withdraw.toUpperCase(),
        body: const WithdrawMoneyBody(),
      ),
    );
  }
}
