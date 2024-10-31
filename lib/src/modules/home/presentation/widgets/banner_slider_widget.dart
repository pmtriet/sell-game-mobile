part of '../pages/home_page.dart';

class BannerSliderWidget extends StatelessWidget {
  const BannerSliderWidget({super.key, required this.banners});

  final List<AppBanner> banners;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = banners
        .map((banner) => BannerCardWidget(
              imgUrl: banner.image.filePath,
            ))
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: SizedBox(
        height: 120.h,
        width: 390.w,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 120.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.78,
            enlargeFactor: 0.3,
          ),
          items: imageSliders,
        ),
      ),
    );
  }
}
