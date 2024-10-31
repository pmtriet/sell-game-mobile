part of '../../pages/withdraw_money_page.dart';

class AvailableBalanceWidget extends StatelessWidget {
  const AvailableBalanceWidget({super.key, required this.balance});
  final int balance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //text withdraw
        Text(
          context.s.available_balance,
          style: context.textTheme.headlineSmall,
        ),
        //available balance money
        Text(
          '${balance.toNumberFormat()}${context.s.currency_unit}',
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
