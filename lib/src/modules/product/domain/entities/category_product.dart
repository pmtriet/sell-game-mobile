import '../../../home/domain/entities/category.dart';

abstract class ProductModel {
  int get id;
  String get title;
  String get description;
  String get code;
  int get price;
  double get saleOff;
  String get rank;
  ProductSignInMethod get signInMethod;
  List<ProductImage> get images;
  List<ProductAttribute> get attributes;
  String get createdAt;
  Category get category;
}

abstract class ProductSignInMethod {
  int get id;
  String get title;
}

abstract class ProductImage {
  String get filePath;
}

abstract class ProductAttribute {
  String get key;
  String get title;
  String get value;
}
