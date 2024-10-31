part of '../pages/phone_verification_page.dart';

class PhoneVerificationBody extends StatelessWidget {
  const PhoneVerificationBody({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    var controllor = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.router.maybePop();
              context.read<CountingTextfieldCubit>().stopCountdown();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorName.primary,
            )),
        titleSpacing: 0,
        title: Text(
          context.s.verification_phone_number.toUpperCase(),
          style: context.textTheme.headlineSmall.copyWith(fontSize: 16),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorName.background,
      ),
      backgroundColor: ColorName.background,
      body: BlocListener<PhoneVerificationCubit, PhoneVerificationState>(
        listener: (context, state) {
          state.whenOrNull(error: (message) {
            AppDialogs.show(type: AlertType.error,content: message);
          });
          state.whenOrNull(success: () {
            context.read<CountingTextfieldCubit>().stopCountdown();
            context.router.popUntil((route) => route.isFirst);
            context.router.push(const SettingAccountRoute());
          });
          state.whenOrNull(
            resend: () => context.read<CountingTextfieldCubit>().countdown(),
          );
        },
        child: BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UIConstants.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.s.enter_otp,
                        style: context.textTheme.contentSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          phoneNumber,
                          style: context.textTheme.headingSmall,
                        ),
                      ),
                      BlocBuilder<CountingTextfieldCubit,
                          CountingTextfieldState>(
                        builder: (context, state) {
                          return state.when(
                            counting: (count) => EditionTextFieldWidget(
                              hintText: context.s.verification_code,
                              suffixText: TextButton(
                                onPressed: null,
                                child: Text(
                                  '($count${context.s.second})',
                                  style: context.textTheme.displaySmall,
                                ),
                              ),
                              controller: controllor,
                            ),
                            resend: () => EditionTextFieldWidget(
                              hintText: context.s.verification_code,
                              controller: controllor,
                              suffixButton: TextButton(
                                onPressed: () {
                                  context
                                      .read<PhoneVerificationCubit>()
                                      .resendOtp();
                                },
                                child: Text(
                                  context.s.resend,
                                  style: context.textTheme.caption,
                                ),
                              ),
                            ),
                            initial: () => EditionTextFieldWidget(
                              hintText: context.s.verification_code,
                              controller: controllor,
                            ),
                          );
                        },
                      ),
                      ButtonWidget(
                        title: context.s.confirm,
                        onTextButtonPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context
                              .read<PhoneVerificationCubit>()
                              .validate(controllor.text);
                        },
                      ),
                    ],
                  ),
                ),
                if (state == const PhoneVerificationState.loading())
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
