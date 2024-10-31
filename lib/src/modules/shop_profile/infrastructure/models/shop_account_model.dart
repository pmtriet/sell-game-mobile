import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/infrastructure/models/user_avatar_model.dart';
import '../../../auth/infrastructure/models/user_background_model.dart';
import 'shop_number_products_model.dart';

part 'shop_account_model.freezed.dart';
part 'shop_account_model.g.dart';

@freezed
class ShopAccountModel with _$ShopAccountModel {
  const ShopAccountModel._();

  const factory ShopAccountModel({
    @Default(0) int id,
    @Default('') String fullname,
    @Default(UserAvatarModel()) UserAvatarModel avatar,
    @Default(UserBackgroundModel()) UserBackgroundModel background,
    @Default([]) List<int> follower,
    @Default([]) List<int> following,
    @Default(0.0) double avgRating,
    @Default(ShopNumberProductsModel()) ShopNumberProductsModel count,
    @Default('') String createdAt,
  }) = _ShopAccountModel;

  factory ShopAccountModel.fromJson(dynamic json) => _$ShopAccountModelFromJson(json);
}
