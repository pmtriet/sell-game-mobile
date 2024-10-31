import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_product_model.freezed.dart';
part 'account_product_model.g.dart';

@freezed
class AccountProductModel with _$AccountProductModel {
  const AccountProductModel._();

  const factory AccountProductModel({
    @Default('') String account,
    @Default('') String password,
  }) = _AccountProductModel;

  factory AccountProductModel.fromJson(Map<String, dynamic> json) =>
      _$AccountProductModelFromJson(json);
}
