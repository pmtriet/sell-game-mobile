part of '../pages/category_page.dart';

class FilterSideSheetWidget extends StatelessWidget {
  const FilterSideSheetWidget(
      {super.key,
      required this.ranks,
      required this.minPriceController,
      required this.maxPriceController});
  final List<String> ranks;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        color: ColorName.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 56),
                      child: Text(
                        context.s.search_filter,
                        style: context.textTheme.captionLarge,
                      ),
                    ),

                    Text(
                      '${context.s.price_range} (${context.s.currency_unit})',
                      style: context.textTheme.headlineSmall,
                    ),

                    //textfield price
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //min
                          PriceTextFieldWidget(
                            hintText: context.s.minimum,
                            controller: minPriceController,
                          ),
                          const Icon(
                            Icons.horizontal_rule,
                            color: ColorName.grey787878,
                            size: 15,
                          ),
                          //max
                          PriceTextFieldWidget(
                            hintText: context.s.maximum,
                            controller: maxPriceController,
                          ),
                        ],
                      ),
                    ),

                    //rank

                    Flexible(
                      child: BlocBuilder<RanksFilterCubit, RanksFilterState>(
                        builder: (context, state) {
                          return state.ranks != null && state.ranks!.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text(
                                        context.s.rank,
                                        style: context.textTheme.headlineSmall,
                                      ),
                                    ),
                                    GridviewRanksWidget(
                                      ranks: state.ranks!,
                                      viewMore: state.more,
                                      selectedranks: state.selectedRanks,
                                      onTap: (selectedRank) {
                                        context
                                            .read<RanksFilterCubit>()
                                            .onTapRank(selectedRank);
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //button
              BlocBuilder<RanksFilterCubit, RanksFilterState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilterButtonWidget(
                          enable: false,
                          title: context.s.cancel,
                          onTap: () {
                            context
                                .read<RanksFilterCubit>()
                                .onClearSelectedRanks();

                            Navigator.of(context).pop(FilterResult(
                              action: FilterAction.clear,
                            ));
                          },
                        ),
                        FilterButtonWidget(
                            enable: true,
                            title: context.s.apply,
                            onTap: () {
                              int? minPrice =
                                  minPriceController.text.toNumber();
                              int? maxPrice =
                                  maxPriceController.text.toNumber();

                              if (minPrice != null &&
                                  maxPrice != null &&
                                  minPrice > maxPrice) {
                                AppDialogs.show(
                                    type: AlertType.error,
                                    content:
                                        context.s.error_min_max_price_filter);
                              } else {
                                Navigator.of(context).pop(FilterResult(
                                  data: FilterPriceRankModel(
                                    minPrice: minPrice,
                                    maxPrice: maxPrice,
                                    rankNames: state.selectedRanks,
                                  ),
                                  action: FilterAction.apply,
                                ));
                              }
                            }),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
