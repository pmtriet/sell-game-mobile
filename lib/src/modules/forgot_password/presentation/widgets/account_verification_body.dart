part of '../pages/account_verification_page.dart';

class AccountVerificationBody extends StatelessWidget {
  const AccountVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return BlocListener<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, state) {
        if (state.error != null) {
          AppDialogs.show(type: AlertType.error, content: state.error!);
        } else if (state.success != null) {
          context.router.push(ResendEmailRoute(email: controller.text.trim()));
        }
      },
      child: BlocBuilder<AccountVerificationCubit, AccountVerificationState>(
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UIConstants.padding),
                  child: Column(
                    children: [
                      Text(
                        context.s.verify_account_content,
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      //textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: BlocBuilder<AccountVerificationCubit,
                            AccountVerificationState>(
                          builder: (context, state) {
                            return TextField(
                              controller: controller,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorName.grey353535,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorName.primary,
                                  ),
                                ),
                                hintText: context.s.enter_email,
                                hintStyle: context.textTheme.captionMedium,
                                errorText: state.errorEmail,
                                errorMaxLines: 2,
                              ),
                              style: context.textTheme.captionMedium,
                            );
                          },
                        ),
                      ),
                      //button
                      ButtonWidget(
                          title: context.s.next,
                          onTextButtonPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context
                                .read<AccountVerificationCubit>()
                                .forgetPassword(controller.text);
                          }),
                    ],
                  ),
                ),
              ),
              if (state.isLoading)
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
    );
  }
}
