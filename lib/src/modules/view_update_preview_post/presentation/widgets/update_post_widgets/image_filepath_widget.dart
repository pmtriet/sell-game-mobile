part of '../../page/update_post_page.dart';

class ImageFromFilePathWidget extends StatelessWidget {
  const ImageFromFilePathWidget(
      {super.key,
      required this.imageFilePath,
      required this.onDeleteSelectedRemainingImage,
      this.isFirst});
  final String imageFilePath;
  final VoidCallback onDeleteSelectedRemainingImage;
  final bool? isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 77.w,
          height: 77.w,
          decoration: BoxDecoration(
            color: ColorName.grey353535,
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            border: Border.all(color: ColorName.grey353535),
          ),
          child: Center(
            child: SizedBox(
                height: 50.w,
                width: 77.w,
                child: imageFilePath.isNotEmpty
                    ? CacheImageWidget(
                        url: imageFilePath,
                        fit: BoxFit.cover,
                      )
                    : Assets.icons.deletedImage.svg()),
          ),
        ),
        Positioned(
          top: 4.w,
          right: 4.w,
          child: GestureDetector(
            onTap: onDeleteSelectedRemainingImage,
            child: const Icon(
              Icons.close,
              size: 18,
              color: ColorName.whiteF1F1F1,
            ),
          ),
        ),
        //gradient background
        if (isFirst != null)
          Positioned.fill(
            top: 40,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    ColorName.green3BD9AC.withOpacity(0.7),
                    Colors.transparent
                  ])),
            ),
          ),
        if (isFirst != null)
          //text background
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 4),
              child: Text(
                context.s.background_image,
                style: context.textTheme.contentSmall,
              ),
            ),
          ),
      ],
    );
  }
}
