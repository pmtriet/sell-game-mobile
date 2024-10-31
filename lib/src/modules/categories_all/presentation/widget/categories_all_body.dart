part of '../page/categories_all_page.dart';

class CategoriesAllBody extends StatelessWidget {
  const CategoriesAllBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: context.router.maybePop,
            icon: const Icon(
              Icons.arrow_back,
              color: ColorName.primary,
            )),
        titleSpacing: 0, //reduce space beween leading and title
        surfaceTintColor: Colors.transparent,//handle appbar change color when scroll
        title: Text(
          context.s.all_game.toUpperCase(),
          style: context.textTheme.headlineSmall
              .copyWith(color: ColorName.primary),
        ),
        backgroundColor: ColorName.background,
      ),
      backgroundColor: ColorName.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
        child: Column(
          children: [
            Expanded(child: BlocBuilder<CategoriesAllCubit, CategoriesAllState>(
              builder: (context, state) {
                return state.when(initial: (isLoading, categories) {
                  return Stack(
                    children: [
                      categories != null
                          ? GridviewCategoriesWidget(
                              categories: categories,
                              refresh:
                                  context.read<CategoriesAllCubit>().refresh,
                              // loadMore: () {},
                            )
                          : const SizedBox.shrink(),
                      if (isLoading)
                        Container(
                          color: ColorName.background.withOpacity(0.5),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: ColorName.primary,
                          )),
                        )
                    ],
                  );
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
