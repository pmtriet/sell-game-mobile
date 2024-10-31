import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/enum_product_type.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/open_deeplink.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../app/app_router.dart';
import '../../../buy/presentation/widgets/product_details_widget.dart';
import '../../../buy/presentation/widgets/product_summary_widget.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../../../view_update_preview_post/presentation/page/view_post_page.dart';
import '../../application/cubit/order_history_cubit.dart';
import '../../domain/interface/order_history_repository_interface.dart';

part '../widget/order_history_body.dart';
part '../components/row_infor_widget.dart';
part '../components/product_code_row_widget.dart';

@RoutePage()
class OrderHistoryPage extends StatelessWidget {
  final int transactionId;
  const OrderHistoryPage({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) =>
          OrderHistoryCubit(transactionId, getIt<IOrderHistoryRepository>()),
      child: OrderHistoryBody(transactionId: transactionId),
    ));
  }
}
