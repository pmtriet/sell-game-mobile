import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/int_x.dart';
import '../../../../common/widgets/search_bar_widget.dart';
import '../../../app/app_router.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../../buy/presentation/widgets/product_summary_widget.dart';
import '../../application/search_cubit.dart';
import '../../application/search_state.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    super.key,
  });

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  context.router.maybePop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                  color: ColorName.primary,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: SearchBarWidget(
                  focusNode: _focusNode,
                  width: double.infinity,
                  hintText: context.s.hint_search,
                  onChanged: cubit.onSearchChanged,
                  onSubmitted: (value) async {
                    if (value.isEmpty) return;
                    final products =
                        await _searchProductsAndNavigate(context, cubit, value);
                    if (products != null) {
                      context.router.push(
                        SearchResultsRoute(products: products, keyword: value),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          // Use Expanded to allow the ListView to take the available space and avoid overflow
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return state.when(
                detail: (keyword, isLoading, products) =>
                    const SizedBox.shrink(),
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (products) {
                  return products == null || products.isEmpty
                      ? const Center(child: Text('No products found.'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: UIConstants
                                  .padding), // Add padding around the ListView
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 16.h), // Add space between items
                              child: GestureDetector(
                                onTap: () {
                                  context.router.push(
                                    ProductRoute(productId: products[index].id),
                                  );
                                },
                                child: ProductSummaryWidget(
                                  imagePath: product.images.first.filePath,
                                  title: product.title,
                                  gameName: product.category.name,
                                  code: product.code,
                                  price: (product.price).toInt().toVND(),
                                  discount: product.saleOff,
                                ),
                              ),
                            );
                          },
                        );
                },
                error: (message) => Center(child: Text(message?? context.s.no_products_found)),
              );
            },
          ),
        ),
      ],
    );
  }

  // Trigger search and return the products for navigation
  Future<List<ProductModel>?> _searchProductsAndNavigate(
      BuildContext context, SearchCubit cubit, String keyword) async {
    await cubit.searchProducts(keyword);

    // Use maybeWhen to handle different states
    return context.read<SearchCubit>().state.maybeWhen(
          loaded: (products) => products, // Return products if state is loaded
          orElse: () => null, // Return null if not in the loaded state
        );
  }
}
