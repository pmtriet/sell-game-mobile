import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../application/withdraw_money_cubit/withdraw_money_cubit.dart';
import '../../infrastructure/models/bank_account_model.dart';

class BankAccountItemWidget extends StatelessWidget {
  const BankAccountItemWidget(
      {super.key,
      required this.bankAccount,
      required this.isActive,
      required this.isDeleted});
  final BankAccountModel bankAccount;
  final bool isActive;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<WithdrawMoneyCubit>().onPressedBankAccount(bankAccount);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //icon active, img, name's bank, account number
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //icon active
                (isActive)
                    ? Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: ColorName.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                    : const SizedBox(
                        width: 12,
                      ),
                //image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConstants.imgRadius),
                        color: ColorName.black1E1E1E),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(UIConstants.imgRadius),
                      child: CacheImageWidget(
                        url: bankAccount.bank != null
                            ? bankAccount.bank!.bankLogoUrl
                            : '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                //bank's name, account n-umber
                SizedBox(
                  width: 260,
                  child: Text(
                    '${bankAccount.bank!.shortName}***${bankAccount.bankNumber}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.captionMedium
                        .copyWith(color: ColorName.greyBBBBBB),
                  ),
                ),
              ],
            ),
          ),
          //delete icon
          GestureDetector(
            onTap: () {
              AppDialogs.show(
                type: AlertType.warning,
                content: context.s.delete_wallet_bank,
                titleAction1: context.s.ok,
                action1: () {
                  context
                      .read<WithdrawMoneyCubit>()
                      .onLongPressedBankAccount(bankAccount);
                  context
                      .read<WithdrawMoneyCubit>()
                      .deleteBankAccount(bankAccount.id);
                },
                titleAction2: context.s.cancel,
              );
            },
            child: const SizedBox(
              width: 20,
              height: 20,
              child: Center(
                child: Icon(
                  Icons.close,
                  color: ColorName.greyD2D2D2,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
