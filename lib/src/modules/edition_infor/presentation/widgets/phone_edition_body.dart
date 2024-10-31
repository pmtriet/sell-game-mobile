
part of '../pages/phone_edition_page.dart';

class PhoneEditionBody extends StatelessWidget {
  const PhoneEditionBody({super.key});

  @override
  Widget build(BuildContext context) {
    var controllor = TextEditingController();
    return BlocListener<PhoneEditionCubit, PhoneEditionState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            AppDialogs.show(
              type: AlertType.error,
               content: message);
          },
        );
      },
      child: BlocBuilder<PhoneEditionCubit, PhoneEditionState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: UIConstants.padding),
            child: Column(
              children: [
                EditionTextFieldWidget(
                  controller: controllor,
                  isPhoneEditting: true,
                  hintText: context.s.phone,
                ),
                ButtonWidget(
                  title: context.s.continue_process,
                  onTextButtonPressed: () {
                    bool result = context
                        .read<PhoneEditionCubit>()
                        .validate(controllor.text);
                    if (result) {
                      context.router.push(
                          PhoneVerificationRoute(phoneNumber: controllor.text));
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
