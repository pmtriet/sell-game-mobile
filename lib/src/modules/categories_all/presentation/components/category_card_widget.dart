part of '../page/categories_all_page.dart';
class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(CategoryRoute(category: category));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //img
          Container(
            width: 111.w,
            height: 111.w,
            decoration: BoxDecoration(
                color: ColorName.black1E1E1E,
                borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                border: Border.all()),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                child: category.thumbnail.filePath.isNotEmpty
                    ? CacheImageWidget(
                        url: category.thumbnail.filePath,
                        fit: BoxFit.cover,
                      )
                    : Assets.icons.deletedImage.svg()),
          ),

          //name
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.headingSmall
                  .copyWith(color: ColorName.greyBBBBBB),
            ),
          ),
        ],
      ),
    );
  }
}
