import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/product.dart';

part 'product_signinmethod_model.freezed.dart';
part 'product_signinmethod_model.g.dart';

@freezed
class ProductSigninmethodModel with _$ProductSigninmethodModel implements ProductSignInMethod {
  const ProductSigninmethodModel._();

  const factory ProductSigninmethodModel({
    @Default(0) int id,
    @Default('') String title,
  }) = _ProductSigninmethodModel;

  factory ProductSigninmethodModel.fromJson(dynamic json) => _$ProductSigninmethodModelFromJson(json);
}
