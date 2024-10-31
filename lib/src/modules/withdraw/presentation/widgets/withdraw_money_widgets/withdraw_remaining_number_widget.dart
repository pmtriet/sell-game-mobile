part of '../../pages/withdraw_money_page.dart';

class WithdrawRemainingNumberWidget extends StatelessWidget {
  const WithdrawRemainingNumberWidget({super.key, required this.numberRemaining});
  final int numberRemaining;

  @override
  Widget build(BuildContext context) {
     return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: context.s.you_have,
            style: context.textTheme.bodyMedium,
          ),
          TextSpan(
            text: numberRemaining.toString(),
            style:
                context.textTheme.bodyMedium.copyWith(color: ColorName.primary),
          ),
          TextSpan(
            text: context.s.number_of_withdrawals_remaining,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}