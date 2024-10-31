abstract class BannerImage {
  String get filePath;
}

abstract class AppBanner {
  int get id;
  BannerImage get image;
}
