part of '../pages/setting_account_page.dart';

class SettingAccountBody extends StatelessWidget {
  const SettingAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final newPasswordAgainController = TextEditingController();
    return SingleChildScrollView(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            unauthenticated: () => context.router.maybePop(),
          );
        },
        child: BlocConsumer<SettingAccountCubit, SettingAccountState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) =>
                  AppDialogs.show(type: AlertType.error, content: message),
              success: (message) {
                AppDialogs.show(type: AlertType.notice, content: message);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //text profile infor
                    RowWidget(
                      title: context.s.personal_profile,
                    ),
                    //infor
                    Padding(
                      padding: const EdgeInsets.all(UIConstants.padding),
                      child: PersonalProfileEditInforWidget(
                          user: context.read<PersonalprofileEditCubit>().user),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: UIConstants.padding, bottom: 2.0),
                      child: Text(
                        context.s.settings,
                        style: context.textTheme.captionSmall,
                      ),
                    ),

                    BlocBuilder<DisplayChangePasswordCubit,
                        DisplayChangePasswordState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            //text change password
                            RowWidget(
                              title: context.s.change_password,
                              enable: true,
                              suffixIcon: state.isDisplayed
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              onTap: () {
                                context
                                    .read<DisplayChangePasswordCubit>()
                                    .changeState();
                              },
                            ),
                            //three textfield change password
                            state.isDisplayed
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: UIConstants.padding),
                                    child: Column(
                                      children: [
                                        BlocBuilder<SettingAccountCubit,
                                            SettingAccountState>(
                                          builder: (context, state) {
                                            return state.maybeWhen(
                                                success: (_) {
                                              currentPasswordController.clear();
                                              newPasswordController.clear();
                                              newPasswordAgainController
                                                  .clear();
                                              return ChangePasswordWidget(
                                                currentPasswordController:
                                                    currentPasswordController,
                                                newPasswordController:
                                                    newPasswordController,
                                                newPasswordAgainController:
                                                    newPasswordAgainController,
                                              );
                                            }, orElse: () {
                                              return ChangePasswordWidget(
                                                currentPasswordController:
                                                    currentPasswordController,
                                                newPasswordController:
                                                    newPasswordController,
                                                newPasswordAgainController:
                                                    newPasswordAgainController,
                                              );
                                            });
                                          },
                                        ),
                                        TwoTextRowWidget(
                                          onPressedForgotPassword: () {},
                                          onPressedSaveChanges: () {
                                            context
                                                .read<SettingAccountCubit>()
                                                .changePassword(
                                                    currentPasswordController
                                                        .text,
                                                    newPasswordController.text,
                                                    newPasswordAgainController
                                                        .text);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        );
                      },
                    ),

                    // //check account activity
                    // RowWidget(
                    //   title: context.s.account_activity,
                    //   enable: true,
                    //   onTap: () {
                    //
                    //   },
                    // ),
                    // //manage login history
                    // RowWidget(
                    //   title: context.s.manage_login_history,
                    //   enable: true,
                    //   onTap: () {
                    //
                    //   },
                    // ),

                    //logout button
                    ButtonWidget(
                      onTap: () => AppDialogs.show(
                        type: AlertType.warning,
                        content: context.s.confirm_logout,
                        action1: () =>
                            context.read<PersonalprofileEditCubit>().logout(),
                      ),
                      title: context.s.logout,
                    ),
                  ],
                ),
                if (state == const SettingAccountState.loading())
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
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
}
