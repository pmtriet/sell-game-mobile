
part of '../pages/name_edition_page.dart';

class NameEditionBody extends StatelessWidget {
  const NameEditionBody({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    var controllor = TextEditingController();
    return BlocListener<NameEditionCubit, NameEditionState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            AppDialogs.show(
              type: AlertType.error,
                content: message);
          },
        );
        state.whenOrNull(success: () {
          context.router.popUntil((route) => route.isFirst);
          context.router.push(const SettingAccountRoute());
        });
      },
      child: BlocBuilder<NameEditionCubit, NameEditionState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: UIConstants.padding),
                child: Column(
                  children: [
                    EditionTextFieldWidget(
                      controller: controllor,
                      hintText: name,
                    ),
                    ButtonWidget(
                      title: context.s.save,
                      onTextButtonPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context
                            .read<NameEditionCubit>()
                            .validate(controllor.text);
                      },
                    ),
                  ],
                ),
              ),
              if (state == const NameEditionState.loading())
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
    );
  }
}
