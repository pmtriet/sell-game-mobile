import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/enum_report_reason.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/image_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../app/app_router.dart';
import '../../../post/presentation/components/add_image_mini_widget.dart';
import '../../../post/presentation/components/image_widget.dart';
import '../../application/cubit/report_cubit.dart';
import '../../domain/report_repository_interface.dart';

part '../widgets/report_body.dart';
part '../widgets/radiobox_widget.dart';
part '../widgets/description_widget.dart';
part '../widgets/add_image_widget.dart';

@RoutePage()
class ReportPage extends StatelessWidget {
  final int transactionId;
  const ReportPage({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(transactionId, getIt<IReportRepository>()),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
          resizeToAvoidBottomInset: false,
          body: ReportBody(
            transactionId: transactionId,
          ),
        )),
      ),
    );
  }
}
