part of '../pages/product_page.dart';

class AccountLinkWidget extends StatelessWidget {
  final String title;
  final String accountName;

  const AccountLinkWidget({
    super.key,
    required this.title,
    required this.accountName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.displaySmall.copyWith(
                color: ColorName.whiteF1F1F1,
              ),
            ),
            Text(
              accountName,
              style: context.textTheme.displaySmall.copyWith(
                color: ColorName.whiteF1F1F1,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
