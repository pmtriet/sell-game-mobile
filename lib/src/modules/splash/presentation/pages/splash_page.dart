import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../app/app_router.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  SplashPage({super.key}) {
    fetchAll();
  }

  fetchAll() async {
    await Future.delayed(3.seconds);
    getIt<AppRouter>().replaceAll([const TabBarRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorName.background,
        body: Center(
      child: SizedBox(
        width: 92.16.w,
        child: Assets.images.authLogo.image(fit: BoxFit.cover,)),
    ));
  }
}
