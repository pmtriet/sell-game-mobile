import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/formatter/trim_text_formatter.dart';
import '../../application/bank_search_cubit/bank_search_cubit.dart';

class SearchbarWidget extends StatelessWidget {
  const SearchbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Container(
      width: 320.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: ColorName.black1E1E1E,
        borderRadius: BorderRadius.circular(UIConstants.imgRadius),
        border: Border.all(color: ColorName.grey353535),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (text) {
          context.read<BankSearchCubit>().onSearchTextChanged(text);
        },
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          TrimmedTextFormatter(),
        ],
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: ColorName.grey787878,
          ),
          hintText: context.s.search,
          hintStyle: context.textTheme.displaySmall,
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }
}
