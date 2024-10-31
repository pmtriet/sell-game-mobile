part of '../../pages/login_page/login_page.dart';

class LoginBody extends StatelessWidget {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.background,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    //close button
                    Container(
                      width: double.infinity,
                      height: 70,
                      color: ColorName.background,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 24),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: ColorName.primary,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                        child: Center(
                      child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                        state.whenOrNull(
                          error: (error) => error.whenOrNull(
                              other: (message) => AppDialogs.show(
                                  type: AlertType.error, content: message)),
                          //back to previous page if authenticated
                          authenticated: (_) => Navigator.of(context).pop(),
                        );
                      }, builder: (context, state) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(24.w),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                //logo
                                Padding(
                                  padding: EdgeInsets.only(bottom: 40.w),
                                  child: SizedBox(
                                    child: Assets.images.authLogo.image(),
                                  ),
                                ),
                                //email
                                TextFieldWidget(
                                  textEditingController:
                                      _emailTextEditingController,
                                  errorText: state.whenOrNull<String?>(
                                    error: (error) => error.whenOrNull(
                                      invalidEmail: () =>
                                          context.s.error_invalid_email,
                                      emptyEmail: () => context.s.empty_email,
                                    ),
                                  ),
                                  hintText: context.s.hint_text_email,
                                  onFocus: () {
                                    context
                                        .read<AuthCubit>()
                                        .emitToUnauthenticatedState();
                                  },
                                ),
                                //password
                                PasswordWidget(
                                  passwordTextEditingController:
                                      _passwordTextEditingController,
                                  errorText: state.whenOrNull<String?>(
                                    error: (error) => error.whenOrNull(
                                      invalidPasswordLength: () => context
                                          .s.error_invalid_password_length,
                                      invalidPassword: () =>
                                          context.s.error_invalid_password,
                                    ),
                                  ),
                                  hintText: context.s.hint_text_password,
                                  onFocus: () {
                                    context
                                        .read<AuthCubit>()
                                        .emitToUnauthenticatedState();
                                  },
                                ),
                                ButtonWidget(
                                  title: context.s.login.toUpperCase(),
                                  onTextButtonPressed: () => _login(context),
                                ),

                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: GestureDetector(
                                        onTap: () => context.router.push(
                                            const AccountVerificationRoute()),
                                        child: Text(context.s.forgot_password,
                                            style: context
                                                .textTheme.headlineSmall
                                                .copyWith(
                                                    color:
                                                        ColorName.greyD2D2D2)),
                                      ),
                                    ),
                                    TextSpanWidget(
                                      enableTextSpan: context.s.register,
                                      disableTextSpan:
                                          context.s.dont_have_account,
                                      onTextSpanTap: () {
                                        Navigator.pop(context);

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
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ))
                  ],
                ),
                if (state == const AuthState.loading())
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = _emailTextEditingController.text;
    final password = _passwordTextEditingController.text;
    await context
        .read<AuthCubit>()
        .login(LoginRequest(email: email.trim(), password: password));
  }
}
