part of '../pages/home_page.dart';

class BannerCardWidget extends StatelessWidget {
  const BannerCardWidget({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 120.h,
      decoration: BoxDecoration(
          border: Border.all(color: ColorName.green3BD9AC),
          borderRadius: BorderRadius.circular(UIConstants.imgRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UIConstants.imgRadius),
        child: imgUrl.isNotEmpty
            ? CacheImageWidget(
                url: imgUrl,
                fit: BoxFit.cover,
              )
            : Assets.icons.deletedImage.svg(),
      ),
    );
  }
}
