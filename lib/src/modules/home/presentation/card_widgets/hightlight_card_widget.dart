part of '../pages/home_page.dart';


class HighlightCardWidget extends StatelessWidget {
  const HighlightCardWidget(
      {super.key, required this.gradientColor, required this.label});

  final Color gradientColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173.w,
      height: 173.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConstants.itemRadius),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(UIConstants.itemRadius),
              child:
                  Assets.images.homeDefaultImgSlider.image(fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UIConstants.itemRadius),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorName.black.withOpacity(0.4),
                    gradientColor,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(
                label,
                style: context.textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
