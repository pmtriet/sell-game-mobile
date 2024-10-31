import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../modules/register/presentation/page/register_page.dart';
import '../extensions/build_context_x.dart';
import '../theme/text_theme/default_text_theme.dart';
import '../utils/getit_utils.dart';
import '../../modules/auth/presentation/pages/login_page/login_page.dart';

class LoginTextWidget extends StatelessWidget {
  const LoginTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.w,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: RichText(
          text: TextSpan(
            style: getIt<DefaultTextTheme>().displayMedium,
            children: [
              TextSpan(
                text: context.s.login,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //show login screen from bottom
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const AuthPage();
                      },
                      isDismissible: true,
                      elevation: 10,
                      isScrollControlled: true,
                    );
                  },
              ),
              const TextSpan(
                text: '/',
              ),
              TextSpan(
                text: context.s.register,
                recognizer: TapGestureRecognizer()..onTap = () {
                  //show register screen from bottom
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const RegisterPage();
                      },
                      isDismissible: true,
                      elevation: 10,
                      isScrollControlled: true,
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
