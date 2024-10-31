part of '../pages/personal_profile_page.dart';

class ShopStatsWidget extends StatelessWidget {
  const ShopStatsWidget({super.key, required this.user});
  final ShopAccountModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //stats summary
        SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //review
              StatsWidget(
                title: context.s.review,
                figures: user.avgRating.toString(),
              ),
              VerticalDivider(
                color: ColorName.grey787878,
                thickness: 2,
                width: 16.w,
              ),
              //sold
              StatsWidget(
                title: context.s.sold,
                figures: user.count.transactions.toString(),
              ),
              VerticalDivider(
                color: ColorName.grey787878,
                thickness: 2,
                width: 16.w,
              ),
              //selling
              StatsWidget(
                title: context.s.selling,
                figures: user.count.products.toString(),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 18.w,
        ),

        //Participated days
        Container(
          height: 40.w,
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.grey353535),
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: const Icon(
                    Icons.date_range,
                    color: ColorName.grey8E8E8E,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: context.s.participated,
                        style: context.textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text:
                            '${user.createdAt.toDurationInDaysUntilNow()} ${context.s.date}',
                        style: context.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
