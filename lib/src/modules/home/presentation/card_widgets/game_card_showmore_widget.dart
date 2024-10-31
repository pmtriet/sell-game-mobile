part of '../pages/home_page.dart';


class GameCardShowMoreWidget extends StatelessWidget {
  const GameCardShowMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const CategoriesAllRoute());
      },
      child: Container(
        width: 52.w,
        height: 52.w,
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.primary, width: 1.5),
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: const Center(
          child: Icon(
            Icons.more_horiz,
            color: ColorName.grey787878,
          ),
        ),
      ),
    );
  }
}
