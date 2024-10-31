// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../../generated/assets.gen.dart';
// import '../../../../../generated/colors.gen.dart';
// import '../../../../common/constants/ui_constants.dart';
// import '../../../../common/extensions/build_context_x.dart';
// import '../../../../common/extensions/string_x.dart';
part of '../page/profile_page.dart';

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({super.key, this.availableBalance, this.pendingBalance});
  final int? availableBalance;
  final int? pendingBalance;

  @override
  Widget build(BuildContext context) {
    int availableMoney = availableBalance ?? 0;
    int pendingMoney = pendingBalance ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 175.w,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(UIConstants.itemRadius)),
                color: ColorName.grey353535),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.w, 2.w, 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.s.available_balance,
                    style: context.textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${availableMoney.toNumberFormat()}${context.s.currency_unit}',
                          style: availableMoney.toString().length < 10
                              ? context.textTheme.displayLarge
                                  .copyWith(fontSize: 14)
                              : context.textTheme.displayLarge
                                  .copyWith(fontSize: 12),
                          maxLines: 1,
                        ),
                        IconButton(
                            onPressed: () {
                              //TODO: add money to account
                            },
                            icon: Assets.icons.plus.svg()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 175.w,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(UIConstants.itemRadius)),
                color: ColorName.grey353535),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.w, 2.w, 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.s.pending_balance,
                    style: context.textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${pendingMoney.toNumberFormat()}${context.s.currency_unit}',
                          style: pendingMoney.toString().length < 10
                              ? context.textTheme.displayLarge
                                  .copyWith(fontSize: 14)
                              : context.textTheme.displayLarge
                                  .copyWith(fontSize: 12),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
