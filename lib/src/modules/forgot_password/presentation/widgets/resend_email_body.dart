part of '../pages/resend_email_page.dart';

class ResendEmailBody extends StatelessWidget {
  final String email;
  const ResendEmailBody({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    bool isTap = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<CounterCubit>().stopCounting();
              context.router.maybePop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorName.primary,
            )),
        title: Text(
          context.s.check_your_email.toUpperCase(),
          style: context.textTheme.headlineSmall,
        ),
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorName.background,
      ),
      backgroundColor: ColorName.background,
      body: BlocListener<ResendEmailCubit, ResendEmailState>(
        listener: (context, state) {
          state.whenOrNull(error: (message) {
            context.read<CounterCubit>().stopCounting();

            AppDialogs.show(type: AlertType.error, content: message);
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '${context.s.check_your_email_content1} ',
                  style: context.textTheme.bodyMedium,
                ),
                TextSpan(text: email, style: context.textTheme.caption),
                TextSpan(
                    text: '. ${context.s.check_your_email_content2}',
                    style: context.textTheme.bodyMedium),
              ])),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ButtonWidget(
                  title: context.s.confirm,
                  onTextButtonPressed: () {
                    context.read<CounterCubit>().stopCounting();

                    context.router.popUntil((route) => route.isFirst);

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
              ),
              BlocListener<CounterCubit, CounterState>(
                listenWhen: (previousState, currentState) {
                  return currentState == const CounterState.initial();
                },
                listener: (context, state) {
                  isTap = false;
                },
                child: BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    return RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: '${context.s.not_receive_email_yet} ',
                        style: context.textTheme.bodyMedium,
                      ),
                      TextSpan(
                          text: state.when(
                              initial: () => context.s.resend,
                              count: (counting) => '${counting}s'),
                          style: context.textTheme.caption,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              state.whenOrNull(
                                initial: () {
                                  if (!isTap) {
                                    isTap = true;
                                    context.read<CounterCubit>().onCount();
                                    context
                                        .read<ResendEmailCubit>()
                                        .resendEmail(email);
                                  }
                                },
                              );
                            }),
                    ]));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
