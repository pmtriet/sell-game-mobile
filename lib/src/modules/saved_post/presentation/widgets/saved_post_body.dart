part of '../pages/saved_post_page.dart';

class SavedPostBody extends StatelessWidget {
  const SavedPostBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SavedPostCubit, SavedPostState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppDialogs.show(type: AlertType.error, content: state.errorMessage!);
        }
      },
      child: BlocBuilder<SavedPostCubit, SavedPostState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: UIConstants.padding),
                child: ListviewSavedPostWidget(
                  savedPosts: state.posts,
                  loadmore: () => context.read<SavedPostCubit>().loadmore(),
                  refresh: () => context.read<SavedPostCubit>().refresh(),
                  // onLoading: () =>
                  //     context.read<SavedPostCubit>().emitToLoading(),
                  // unLoading: () =>
                  //     context.read<SavedPostCubit>().emitToUnloading(),
                  deleteSavedPost: (id) =>
                      context.read<SavedPostCubit>().deleteSavedPost(id),
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
