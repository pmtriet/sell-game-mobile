import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/colors.gen.dart';
import '../../modules/app/app_router.dart';
import '../../modules/buy/infrastructor/models/category_product.dart';
import '../../modules/home/infrastructure/models/category_product_models/product_model.dart';
import '../extensions/build_context_x.dart';
import 'no_post_widget.dart';
import 'product_card_widget.dart';

class ProductsListViewWidget extends StatefulWidget {
  const ProductsListViewWidget({
    super.key,
    this.products = const [],
    required this.refresh,
    required this.loadMore,
    this.categoryName = '',
    this.modelProducts = const [],
  });

  final List<CategoryProductModel> products;
  final List<ProductModel>? modelProducts;
  final String categoryName;
  final VoidCallback refresh;
  final Future<void> Function() loadMore;

  @override
  ProductsListViewWidgetState createState() => ProductsListViewWidgetState();
}

class ProductsListViewWidgetState extends State<ProductsListViewWidget> {
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        if (mounted) {
          setState(() {
            isLoadingMore = true;
          });
        }
        await widget.loadMore();
        if (mounted) {
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    }
  }

  void _refresh() {
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _refresh();
        },
        color: ColorName.primary,
        child: Stack(
          children: [
            ListView(),
            widget.products.isEmpty
                ? Center(
                    child: NoPostWidget(content: context.s.no_products_found),
                  )
                : CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 173 / 253,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 16.w,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index < widget.products.length) {
                              return GestureDetector(
                                onTap: () {
                                  context.router.push(ProductRoute(
                                      productId: widget.products[index].id));
                                },
                                child: ProductCardWidget(
                                  product: widget.products[index],
                                  categoryName: widget.categoryName,
                                ),
                              );
                            }
                            return null;
                          },
                          childCount: widget.products.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: ColorName.primary,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
          ],
        ));
  }
}
