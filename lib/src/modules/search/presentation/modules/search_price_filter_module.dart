import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../category/application/filter_cubit/filter_price_cubit/filter_price_cubit.dart';
import '../../application/search_cubit.dart';


class SearchPriceFilterModule extends StatelessWidget {
  const SearchPriceFilterModule({super.key, required this.priceFilterOption});
  final int priceFilterOption; // 1: low to high, 2: high to low

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (priceFilterOption) {
          case 1: //low to high price -> high to low
            context.read<FilterPriceCubit>().filterPriceHighToLow();
            context.read<SearchCubit>().filterByPriceHighToLow();
            break;
          case 2: //high to low price -> low to high
            context.read<FilterPriceCubit>().filterPriceLowToHigh();
            context.read<SearchCubit>().filterByPriceLowToHigh();
            break;
        }
      },
      child: Container(
        height: 40.w,
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 4.w),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //label
                Text(
                  context.s.price,
                  style: context.textTheme.titleMedium.copyWith(fontSize: 12),
                ),
                SizedBox(
                  width: 4.w,
                ),

                if (priceFilterOption == 1) _arrowUpWidget(),

                if (priceFilterOption == 2) _arrowDownWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _arrowUpWidget() {
    return const Icon(
      Icons.keyboard_arrow_up_outlined,
      color: ColorName.black1E1E1E,
      size: 20,
    );
  }

  Widget _arrowDownWidget() {
    return const Icon(
      Icons.keyboard_arrow_down_outlined,
      color: ColorName.black1E1E1E,
      size: 20,
    );
  }
}
