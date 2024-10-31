part of '../pages/transaction_history_page.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key, required this.transactionHistory});
  final PaymentHistoryModel transactionHistory;

  @override
  Widget build(BuildContext context) {
    final transactionType =
        getTransactionTypeFromString(transactionHistory.type);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            height: 47.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //icon & payment method & time
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //icon
                    transactionType.icon,
                    const SizedBox(
                      width: 12,
                    ),
                    //payment method & time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactionType.text,
                          style: context.textTheme.captionSmall,
                        ),
                        Text(
                          transactionHistory.createdAt.toDateTimeFormat(),
                          style: context.textTheme.contentSmall
                              .copyWith(color: ColorName.grey8E8E8E),
                        ),
                      ],
                    )
                  ],
                ),
                //amount
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (transactionType == TransactionType.withdraw ||
                              transactionType == TransactionType.purchase)
                          ? '-${transactionHistory.value.toNumberFormat()}'
                          : '+${transactionHistory.value.toNumberFormat()}',
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      convertTransactionStatusToString(
                          transactionHistory.status),
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${context.s.transaction_code}: ',
                style: context.textTheme.contentSmall
                    .copyWith(color: ColorName.grey8E8E8E),
              ),
              Text(
                transactionHistory.code,
                style: context.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Divider(
          color: ColorName.grey353535,
          thickness: 1,
        )
      ],
    );
  }
}
