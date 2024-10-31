import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../category/application/filter_cubit/filter_option_cubit/filter_option_cubit.dart';
import '../../../category/presentation/modules/option_filter_module.dart';
import '../../application/search_cubit.dart';
import '../modules/search_price_filter_module.dart';


class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({super.key, required this.isSelectedNewestOption, required this.priceFilterOption, required this.onTapFilter});

  final bool isSelectedNewestOption;

  final int priceFilterOption;//0: no filter, 1: low to high, 2: high to low

  final VoidCallback onTapFilter;

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
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
              //api
              context.read<SearchCubit>().filterByNewest();
            },
          ),
          SizedBox(width: 15.w),
          OptionFilterModule(
            label: context.s.sale,
            isSelected: !widget.isSelectedNewestOption,
            onTap: () {
              //change UI filter
              context.read<FilterOptionCubit>().tapOnSaleOption();
              //api
              context.read<SearchCubit>().filterBySale();
            },
          ),
          SizedBox(width: 15.w),
          SearchPriceFilterModule(priceFilterOption: widget.priceFilterOption,),
          SizedBox(width: 15.w),
          // FilterModule(onTap: widget.onTapFilter,),
        ],
      ),
    );
  }
}
