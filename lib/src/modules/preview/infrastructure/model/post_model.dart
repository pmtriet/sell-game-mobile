import 'dart:core';
import 'dart:io';

import '../../../home/domain/entities/category.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';

class PostModel {
  Category category;
  String title;
  List<File> images;
  int price;
  List<CategoryAttributeModel> attributes;
  String? rank;
  CategorySigninMethodModel signInMethod;
  String description;
  String account;
  String password;

  PostModel({
    required this.category,
    required this.title,
    required this.images,
    required this.price,
    required this.attributes,
    required this.rank,
    required this.signInMethod,
    required this.description,
    required this.account,
    required this.password,
  });
}
