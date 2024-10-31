import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'search_product_card_widget.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../app/app_router.dart';
import '../../../buy/infrastructor/models/category_product.dart';



class SearchProductsListViewWidget extends StatefulWidget {
  const SearchProductsListViewWidget({
    super.key,
    this.refresh,
    required this.loadMore,
    required this.modelProducts,
  });


  final List<ProductModel> modelProducts;
  final VoidCallback? refresh;
  final Future<void> Function() loadMore;

  @override
  SearchProductsListViewWidgetState createState() => SearchProductsListViewWidgetState();
}

class SearchProductsListViewWidgetState extends State<SearchProductsListViewWidget> {
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

  // void _refresh() {
  //   widget.refresh();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 173 / 233,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 16.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index < widget.modelProducts.length) {
                return GestureDetector(
                  onTap: () {
                    context.router.push(
                        ProductRoute(productId: widget.modelProducts[index].id));
                  },
                  child: SearchProductCardWidget(
                    modelProducts: widget.modelProducts[index],
                  ),
                );
              }
              return null;
            },
            childCount: widget.modelProducts.length,
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
    );
  }
}
