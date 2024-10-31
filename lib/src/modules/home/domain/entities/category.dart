abstract class Category {
  int get id;
  String get name;
  String get slug;
  List<CategoryAttribute> get attributes;
  List<String> get ranks;
  List<CategorySignInMethod> get signInMethods;
  CategoryThumbnail get thumbnail;
}

abstract class CategoryAttribute {
  String get key;
  String get title;
  String get value;
}

abstract class CategorySignInMethod {
  int get id;
  String get title;
}

abstract class CategoryThumbnail {
  String get filePath;
}
