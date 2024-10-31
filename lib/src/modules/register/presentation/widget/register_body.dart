part of '../page/register_page.dart';

class RegisterBody extends StatelessWidget {
  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.background,
        body: BlocBuilder<RegisterCubit, RegisterState>(
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
                              // back to the previous screen from bottom sheet
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            state.whenOrNull(
                                //show error
                                error: (error) => error.whenOrNull(
                                    other: (message) => AppDialogs.show(
                                        type: AlertType.error,
                                        content: message)),
                                //show popup success -> push to login page
                                success: () {
                                  Navigator.pop(context);
                                  AppDialogs.show(
                                      type: AlertType.notice,
                                      content:
                                          context.s.please_verify_your_email);

                                  // showModalBottomSheet<void>(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return const AuthPage();
                                  //   },
                                  //   isDismissible: true,
                                  //   elevation: 10,
                                  //   isScrollControlled: true,
                                  // );
                                });
                          },
                          builder: (context, state) {
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
                                          // width: 226.53.w,
                                          child: Assets.images.authLogo
                                              .image(fit: BoxFit.cover)),
                                    ),
                                    //name
                                    TextFieldWidget(
                                      textEditingController:
                                          _nameTextEditingController,
                                      errorText: state.whenOrNull<String?>(
                                        error: (error) => error.whenOrNull(
                                          invalidName: () =>
                                              context.s.error_invalid_name,
                                          emptyName: () => context.s.empty_name,
                                        ),
                                      ),
                                      hintText: context.s.hint_text_name,
                                      onFocus: () {
                                        context
                                            .read<RegisterCubit>()
                                            .emitToInitialState();
                                      },
                                    ),
                                    //email
                                    TextFieldWidget(
                                      textEditingController:
                                          _emailTextEditingController,
                                      errorText: state.whenOrNull<String?>(
                                        error: (error) => error.whenOrNull(
                                          invalidEmail: () =>
                                              context.s.error_invalid_email,
                                          emptyEmail: () =>
                                              context.s.empty_email,
                                        ),
                                      ),
                                      hintText: context.s.hint_text_email,
                                      onFocus: () {
                                        context
                                            .read<RegisterCubit>()
                                            .emitToInitialState();
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
                                            .read<RegisterCubit>()
                                            .emitToInitialState();
                                      },
                                    ),
                                    BlocBuilder<CheckboxCubit, CheckboxState>(
                                      builder: (context, state) {
                                        return ButtonWidget(
                                          title:
                                              context.s.register.toUpperCase(),
                                          onTextButtonPressed: () =>
                                              _register(context),
                                          isDisable: (state ==
                                              const CheckboxState.unchecked()),
                                        );
                                      },
                                    ),
                                    const CheckboxRowWidget(),
                                    TextSpanWidget(
                                      enableTextSpan: context.s.login,
                                      disableTextSpan: context.s.have_account,
                                      onTextSpanTap: () {
                                        Navigator.pop(context);

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
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (state == const RegisterState.loading())
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

  void _register(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (context.read<CheckboxCubit>().state ==
        const CheckboxState.unchecked()) {
      AppDialogs.show(
          type: AlertType.notice,
          content: context.s.please_agree_terms_service);
    } else {
      final name = _nameTextEditingController.text;
      final email = _emailTextEditingController.text;
      final password = _passwordTextEditingController.text;

      await context.read<RegisterCubit>().register(RegisterRequest(
          fullname: name, email: email.trim(), password: password));
    }
  }
}
