part of '../pages/home_page.dart';


class GameCategoryWidget extends StatelessWidget {
  const GameCategoryWidget({super.key, required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    int numGames = categories.length;

    int halfIndex = AppConstants.maxCategoryDisplayInRow;
    int maxIndex = AppConstants.maxCategoryDisplay;

    if (numGames < halfIndex) {
      halfIndex = numGames;
    }

    final List<Category> firstRowGames = categories.sublist(0, halfIndex);
    late List<Category> secondRowGames;

    if (numGames <= maxIndex) {
      secondRowGames = categories.sublist(halfIndex, numGames);
    } else {
      secondRowGames = categories.sublist(halfIndex, maxIndex);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(AppConstants.maxCategoryDisplayInRow, (index) {
                if (index < firstRowGames.length) {
                  return GameCardWidget(category: firstRowGames[index]);
                } else {
                  return SizedBox(
                    width: 52.w,
                    height: 52.w,
                  );
                }
              }),
            )),
        (numGames <= maxIndex)
            ? secondRowGames.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(AppConstants.maxCategoryDisplayInRow, (index) {
                        if (index < secondRowGames.length) {
                          return GameCardWidget(
                              category: secondRowGames[index]);
                        } else {
                          return SizedBox(
                            width: 52.w,
                            height: 52.w,
                          );
                        }
                      }),
                    ),
                  )
                : const SizedBox.shrink()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...secondRowGames.sublist(0, secondRowGames.length - 1).map(
                        (gameItem) => GameCardWidget(category: gameItem),
                      ),
                  //show more
                  const GameCardShowMoreWidget(),
                ],
              ),
      ],
    );
  }
}
