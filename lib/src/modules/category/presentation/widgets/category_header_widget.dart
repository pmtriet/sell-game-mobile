part of '../pages/category_page.dart';

class CategoryHeaderWidget extends StatelessWidget {
  const CategoryHeaderWidget({super.key, required this.gameName});
  final String gameName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.w,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //icon back
          GestureDetector(
            onTap: () {
              context.router.maybePop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: ColorName.primary,
              size: 24,
            ),
          ),
          //Name
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 10),
              child: Text(
                gameName.toUpperCase(),
                style: context.textTheme.displayMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
