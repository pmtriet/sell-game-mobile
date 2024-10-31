part of 'shop_profile_cubit.dart';

@freezed
class ShopProfileState with _$ShopProfileState {
  const factory ShopProfileState.loaded(bool isLoading, ShopAccountModel? shop, String? error) = _Loaded;
}
