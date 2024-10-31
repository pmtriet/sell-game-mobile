import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/enum_notification_type.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../../common/widgets/no_post_widget.dart';
import '../../application/cubit/notification_cubit.dart';
import '../../domain/interface/notification_repository_interface.dart';
import '../../infrastructure/models/notification_model.dart';
part '../widgets/list_notification_widget.dart';
part '../widgets/notification_body.dart';
part '../card_widgets/notification_card_widget.dart';
part '../card_widgets/notification_icon_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NotificationCubit(getIt<INotificationRepository>()),
        ),
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
      ],
      child: const NotificationBody(),
    ));
  }
}
