import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/image_cropper.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/user.dart';
import '../../application/cubit/personalprofile_edit_cubit.dart';
import '../widgets/personalprofile_edit_infor_widget.dart';
part '../widgets/personalprofile_edit_body.dart';
part '../widgets/personalprofile_edit_img_widget.dart';
part '../components/row_infor_widget.dart';
@RoutePage()
class PersonalProfileEditPage extends StatelessWidget {
  const PersonalProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PersonalprofileEditCubit>(),
        ),
      ],
      child: const PersonalProfileEditBody(),
    ));
  }
}
