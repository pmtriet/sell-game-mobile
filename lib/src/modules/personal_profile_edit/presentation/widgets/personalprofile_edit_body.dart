
part of '../pages/personalprofile_edit_page.dart';

class PersonalProfileEditBody extends StatelessWidget {
  const PersonalProfileEditBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalprofileEditCubit, PersonalprofileEditState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (msg) => AppDialogs.show(type: AlertType.error,content: msg),
        );
      },
      child: BlocBuilder<PersonalprofileEditCubit, PersonalprofileEditState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: context.router.maybePop,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: ColorName.primary,
                    ),
                  ),
                  titleSpacing: 0,
                  title: Text(
                    context.s.edit_profile.toUpperCase(),
                    style: context.textTheme.bodyLarge,
                  ),
                  actions: [
                    // Save button
                    BlocBuilder<PersonalprofileEditCubit,
                        PersonalprofileEditState>(
                      builder: (context, state) {
                        final onPressed = state.maybeWhen(
                          editting: () => () {
                            context.read<PersonalprofileEditCubit>().update();
                          },
                          orElse: () => null,
                        );
                        return TextButton(
                          onPressed: onPressed,
                          child: Text(
                            context.s.save,
                            style: context.textTheme.displayMedium,
                          ),
                        );
                      },
                    ),
                  ],
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: ColorName.background,
                ),
                backgroundColor: ColorName.background,
                body: BlocBuilder<PersonalprofileEditCubit,
                    PersonalprofileEditState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        PersonalProfileEditImgWidget(
                            user:
                                context.read<PersonalprofileEditCubit>().user),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: PersonalProfileEditInforWidget(
                              user: context
                                  .read<PersonalprofileEditCubit>()
                                  .user),
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (state == const PersonalprofileEditState.loading())
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
