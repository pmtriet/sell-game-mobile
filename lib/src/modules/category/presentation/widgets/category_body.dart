part of '../pages/category_page.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    var minPriceController = TextEditingController();
    var maxPriceController = TextEditingController();
    bool filtered = false;
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header
              CategoryHeaderWidget(
                gameName: state.gameName,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //search bar
                  SearchBarWidget(
                    hintText: context.s.input_search,
                    onChanged: (text) =>
                        context.read<CategoryCubit>().onSearchTextChanged(text),
                  ),

                  //list filter
                  BlocBuilder<FilterOptionCubit, FilterOptionState>(
                      builder: (context, state) {
                    bool isSelectedNewestOption = state.when(
                      newestOptionFilter: () => true,
                      saleOptionFilter: () => false,
                    );
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      child: BlocBuilder<FilterPriceCubit, FilterPriceState>(
                        builder: (context, state) {
                          int priceFilterOption = state.when(
                              lowToHigh: () => 1, highToLow: () => 2);
                          return MenuFilterWidget(
                              isSelectedNewestOption: isSelectedNewestOption,
                              priceFilterOption: priceFilterOption,
                              onTapFilter: () async {
                                final data = await SideSheet.right(
                                  context: context,
                                  width: 320.w,
                                  barrierDismissible: false,
                                  body: BlocProvider.value(
                                    value: context.read<RanksFilterCubit>(),
                                    child: FilterSideSheetWidget(
                                      ranks: category.ranks,
                                      minPriceController: minPriceController,
                                      maxPriceController: maxPriceController,
                                    ),
                                  ),
                                );
                                if (context.mounted) {
                                  switch (data.action) {
                                    case FilterAction.apply:
                                      context
                                          .read<CategoryCubit>()
                                          .filterByRank(data.data);

                                      filtered = true;
                                      break;
                                    case FilterAction.clear:
                                      if (filtered) {
                                        filtered = false;

                                        context
                                            .read<CategoryCubit>()
                                            .removeFilter();

                                        maxPriceController.text =
                                            minPriceController.text = '';
                                      }

                                      break;
                                  }
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              });
                        },
                      ),
                    );
                  }),

                  //list products
                  Expanded(
                    child: state.when(initial: (_, isLoading, products) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          //products
                          ProductsListViewWidget(
                            products: products ?? [],
                            refresh: context.read<CategoryCubit>().refresh,
                            loadMore: context.read<CategoryCubit>().loadmore,
                            categoryName: category.name,
                          ),
                          //loading
                          if (isLoading)
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black.withOpacity(0.5),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                        ],
                      );
                    }),
                  ),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}
