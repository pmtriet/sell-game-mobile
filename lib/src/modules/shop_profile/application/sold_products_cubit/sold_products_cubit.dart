import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_product_c2c_status.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/shop_profile_repository_interface.dart';

part 'sold_products_state.dart';
part 'sold_products_cubit.freezed.dart';

class SoldProductsCubit extends Cubit<SoldProductsState>
    with CancelableBaseBloc<SoldProductsState> {
  final IShopProfileRepository _repository;
  final int shopId;
  SoldProductsCubit(this._repository, this.shopId)
      : super(const SoldProductsState.initial(true, null)) {
    getSoldProducts();
  }

  late MetaApiResponse meta;
  List<MarketplaceProductModel> products = [];

  Future<void> getSoldProducts() async {
    final result = await _repository.getShopProducts(
        getProductC2CStatus(ProductC2CStatus.sold), shopId);

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(false, products));
  }

  void refresh() {
    getSoldProducts();
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.getShopProducts(
        getProductC2CStatus(ProductC2CStatus.sold),
        shopId,
        page: meta.page + 1,
      );

      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        products.addAll(List.of(response.data));

        meta = response.meta;

        emit(_Initial(false, products));
      }
    }
  }
}
