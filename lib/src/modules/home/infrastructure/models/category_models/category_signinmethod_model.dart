import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/category.dart';

part 'category_signinmethod_model.freezed.dart';
part 'category_signinmethod_model.g.dart';

@freezed
class CategorySigninMethodModel with _$CategorySigninMethodModel implements CategorySignInMethod {
  const CategorySigninMethodModel._();

  const factory CategorySigninMethodModel({
    @Default(0) int id,
    @Default('') String title,
  }) = _CategorySigninMethodModel;

  factory CategorySigninMethodModel.fromJson(dynamic json) => _$CategorySigninMethodModelFromJson(json);
}