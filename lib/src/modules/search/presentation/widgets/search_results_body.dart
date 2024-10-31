import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'search_filter_widget.dart';
import 'search_gridview_products_widget.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../../category/application/filter_cubit/filter_option_cubit/filter_option_cubit.dart';
import '../../../category/application/filter_cubit/filter_price_cubit/filter_price_cubit.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/search_bar_widget.dart';
import '../../application/search_cubit.dart';
import '../../application/search_state.dart';

class SearchResultsBody extends StatefulWidget {
  const SearchResultsBody({
    super.key,
    required this.products,
    required this.keyword,
  });

  final List<ProductModel> products;
  final String keyword;

  @override
  _SearchResultsBodyState createState() => _SearchResultsBodyState();
}

class _SearchResultsBodyState extends State<SearchResultsBody> {
  @override
  void initState() {
    super.initState();
    // Initialize search with the initial products and keyword
    context.read<SearchCubit>().initializeSearch(widget.keyword, widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.router.maybePop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: ColorName.primary,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: SearchBarWidget(
                  onSearch: () => context.router.maybePop(),
                  hintText: context.s.search,
                  controller: widget.keyword.isNotEmpty
                      ? TextEditingController(text: widget.keyword)
                      : null,
                ),
              ),
            ],
          ),

          // List filter
          BlocBuilder<FilterOptionCubit, FilterOptionState>(
            builder: (context, optionState) {
              bool isSelectedNewestOption = optionState.when(
                newestOptionFilter: () => true,
                saleOptionFilter: () => false,
              );

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 15.w),
                child: BlocBuilder<FilterPriceCubit, FilterPriceState>(
                  builder: (context, priceState) {
                    int priceFilterOption = priceState.when(
                      lowToHigh: () => 1,
                      highToLow: () => 2,
                    );

                    return SearchFilterWidget(
                      isSelectedNewestOption: isSelectedNewestOption,
                      priceFilterOption: priceFilterOption,
                      onTapFilter: () async {
                        // Automatically apply filters when the state changes
                        if (isSelectedNewestOption) {
                          context.read<SearchCubit>().filterByNewest();
                        } else {
                          context.read<SearchCubit>().filterBySale();
                        }

                        // Handle price filtering
                        if (priceFilterOption == 1) {
                          context.read<SearchCubit>().filterByPriceLowToHigh();
                        } else {
                          context.read<SearchCubit>().filterByPriceHighToLow();
                        }
                      },
                    );
                  },
                ),
              );
            },
          ),

          // List products with loadMore managed in ProductsListViewWidget
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (filteredProducts) {
                    return SearchProductsListViewWidget(
                      modelProducts: filteredProducts ?? widget.products,
                      loadMore: context.read<SearchCubit>().loadMore,
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

