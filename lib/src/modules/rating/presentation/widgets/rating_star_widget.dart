part of '../page/rating_page.dart';

class RatingStarWidget extends StatefulWidget {
  const RatingStarWidget({super.key, required this.onRatingStart});
  final Function(int numberStart) onRatingStart;

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  int currentStart = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //1 start
          IconButton(
            onPressed: () {
              if (currentStart != 1) {
                setState(() {
                  currentStart = 1;
                });
                widget.onRatingStart(currentStart);
              }
            },
            icon: currentStart >= 1
                ? Assets.icons.starEnable.svg(
                    width: 24,
                    height: 24,
                  )
                : Assets.icons.starDisable.svg(
                    width: 24,
                    height: 24,
                  ),
          ),
          //2 start
          IconButton(
            onPressed: () {
              if (currentStart != 2) {
                setState(() {
                  currentStart = 2;
                });
                widget.onRatingStart(currentStart);
              }
            },
            icon: currentStart >= 2
                ? Assets.icons.starEnable.svg(
                    width: 24,
                    height: 24,
                  )
                : Assets.icons.starDisable.svg(
                    width: 24,
                    height: 24,
                  ),
          ),
          //3 start
          IconButton(
            onPressed: () {
              if (currentStart != 3) {
                setState(() {
                  currentStart = 3;
                });
                widget.onRatingStart(currentStart);
              }
            },
            icon: currentStart >= 3
                ? Assets.icons.starEnable.svg(
                    width: 24,
                    height: 24,
                  )
                : Assets.icons.starDisable.svg(
                    width: 24,
                    height: 24,
                  ),
          ),
          //4 start
          IconButton(
            onPressed: () {
              if (currentStart != 4) {
                setState(() {
                  currentStart = 4;
                });
                widget.onRatingStart(currentStart);
              }
            },
            icon: currentStart >= 4
                ? Assets.icons.starEnable.svg(
                    width: 24,
                    height: 24,
                  )
                : Assets.icons.starDisable.svg(
                    width: 24,
                    height: 24,
                  ),
          ),
          //5 start
          IconButton(
            onPressed: () {
              if (currentStart != 5) {
                setState(() {
                  currentStart = 5;
                });
                widget.onRatingStart(currentStart);
              }
            },
            icon: currentStart == 5
                ? Assets.icons.starEnable.svg(
                    width: 24,
                    height: 24,
                  )
                : Assets.icons.starDisable.svg(
                    width: 24,
                    height: 24,
                  ),
          ),
        ],
      ),
    );
  }
}
