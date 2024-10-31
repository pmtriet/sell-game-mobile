part of '../../pages/withdraw_money_page.dart';

class AddingBankAccountWidget extends StatelessWidget {
  const AddingBankAccountWidget({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Assets.icons.card.svg(),
              ),
              Text(
                context.s.add_account,
                style: context.textTheme.headlineSmall
                    .copyWith(color: ColorName.greyBBBBBB),
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: ColorName.greyBBBBBB,
          ),
        ],
      ),
    );
  }
}
