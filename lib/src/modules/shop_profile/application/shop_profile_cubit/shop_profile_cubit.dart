import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../domain/interface/shop_profile_repository_interface.dart';
import '../../infrastructure/models/shop_account_model.dart';

part 'shop_profile_state.dart';
part 'shop_profile_cubit.freezed.dart';

class ShopProfileCubit extends Cubit<ShopProfileState>with CancelableBaseBloc<ShopProfileState> {
  final IShopProfileRepository _repository;
  final int shopId;
  ShopProfileCubit(this._repository, this.shopId)
      : super(const ShopProfileState.loaded(true, null, null)) {
    getShopProfile();
  }

  ShopAccountModel? shop;

  Future<void> getShopProfile() async {

    final result = await _repository.getProfileShop(shopId);

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
        shop = response;
        emit(_Loaded(false, shop, null));
      
    } else {
        emit(_Loaded(false, shop, S.current.error_unexpected));
      
    }
  }

  Future<void> followShop() async {

    emit(_Loaded(true, shop, null));

    final result = await _repository.followShop(shopId);

    result.fold((success) {
      getShopProfile();
    }, (failure) {
        emit(_Loaded(false, shop, failure.message));
      
    });
  }
}
