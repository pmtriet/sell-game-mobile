part of '../pages/home_page.dart';


class GameCardWidget extends StatelessWidget {
  const GameCardWidget({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(CategoryRoute(category: category));
      },
      child: Container(
        width: 52.w,
        height: 52.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            border: Border.all()),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          child: category.thumbnail.filePath.isNotEmpty
              ? CacheImageWidget(
                  url: category.thumbnail.filePath,
                  fit: BoxFit.cover,
                )
              : Assets.icons.deletedImage.svg(),
        ),
      ),
    );
  }
}
