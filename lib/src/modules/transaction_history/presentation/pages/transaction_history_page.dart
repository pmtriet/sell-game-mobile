import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../application/order_date_picker_cubit/order_date_picker_cubit.dart';
import '../../application/payment_cubit/payment_cubit.dart';
import '../../application/payment_date_picker_cubit/payment_date_picker_cubit.dart';
import '../../application/transaction_history_tabbar_cubit/transaction_history_tabbar_cubit.dart';
import '../../application/orders_cubit/orders_cubit.dart';
import '../../domain/interface/transaction_history_repository_interface.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../app/app_router.dart';
import '../../infrastructure/models/order_model.dart';
import '../../infrastructure/models/payment_history_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/assets.gen.dart';
import '../../../../common/extensions/date_time_x.dart';
import '../components/star_widget.dart';
import '../components/tab_item_widget.dart';
import '../../../../common/extensions/enum_transaction_type_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/extensions/transaction_module_x.dart';
import '../../../../common/utils/enum_transaction_type.dart';

import '../../../../common/utils/enum_product_type.dart';
import '../../../../common/widgets/cache_image_widget.dart';


part '../widgets/transaction_history_body.dart';
part '../widgets/date_picker_widget.dart';
part '../widgets/listview_order_widget.dart';
part '../widgets/listview_payment_widget.dart';
part '../components/payment_widget.dart';
part '../components/order_widget.dart';

@RoutePage()
class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionHistoryTabbarCubit(),
        ),
        BlocProvider(
          create: (context) =>
              OrdersCubit(getIt<ITransactionHistoryRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              PaymentCubit(getIt<ITransactionHistoryRepository>()),
        ),
        BlocProvider(
          create: (context) => PaymentDatePickerCubit(),
        ),
        BlocProvider(
          create: (context) => OrderDatePickerCubit(),
        ),
      ],
      child: SafeArea(
        child: TransactionHistoryBody(),
      ),
    );
  }
}
