part of '../pages/product_page.dart';

class DescriptionContainerWidget extends StatelessWidget {
  final String title;
  final String description;

  const DescriptionContainerWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: 358.w,
      decoration: BoxDecoration(
        border: Border.all(color: ColorName.grey353535, width: 2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.displaySmall.copyWith(
              color: ColorName.whiteF1F1F1,
            ),
          ),
          SizedBox(
              height: 2.h), // Add spacing between the title and description
          Text(
            description.isNotEmpty
                ? description
                : context.s.seller_did_not_enter_description,
            style: context.textTheme.displaySmall.copyWith(
              color: ColorName.grey8E8E8E,
            ),
          )
        ],
      ),
    );
  }
}
