part of '../pages/category_page.dart';

class MenuFilterWidget extends StatefulWidget {
  const MenuFilterWidget(
      {super.key,
      required this.isSelectedNewestOption,
      required this.priceFilterOption,
      required this.onTapFilter});

  final bool isSelectedNewestOption;

  final int priceFilterOption; //0: no filter, 1: low to high, 2: high to low

  final VoidCallback onTapFilter;

  @override
  State<MenuFilterWidget> createState() => _MenuFilterWidgetState();
}

class _MenuFilterWidgetState extends State<MenuFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OptionFilterModule(
            label: context.s.new_post,
            isSelected: widget.isSelectedNewestOption,
            onTap: () {
              //change UI filter
              context.read<FilterOptionCubit>().tapOnNewestOption();
              //call api to get list products
              context.read<CategoryCubit>().filterByNewest();

              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          SizedBox(width: 15.w),
          OptionFilterModule(
            label: context.s.sale,
            isSelected: !widget.isSelectedNewestOption,
            onTap: () {
              //change UI filter
              context.read<FilterOptionCubit>().tapOnSaleOption();
              //call api to get list products
              context.read<CategoryCubit>().filterBySale();

              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          SizedBox(width: 15.w),
          PriceFilterModule(
            priceFilterOption: widget.priceFilterOption,
          ),
          SizedBox(width: 15.w),
          FilterModule(
            onTap: widget.onTapFilter,
          ),
        ],
      ),
    );
  }
}
