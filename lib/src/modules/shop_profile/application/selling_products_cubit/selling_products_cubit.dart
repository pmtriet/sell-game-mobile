import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_product_c2c_status.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/shop_profile_repository_interface.dart';

part 'selling_products_state.dart';
part 'selling_products_cubit.freezed.dart';

class SellingProductsCubit extends Cubit<SellingProductsState> with CancelableBaseBloc<SellingProductsState>{
  final IShopProfileRepository _repository;
  final int shopId;
  SellingProductsCubit(this._repository, this.shopId)
      : super(const SellingProductsState.initial(true, null)) {
    getSellingProducts();
  }

  late MetaApiResponse meta;
  List<MarketplaceProductModel> products = [];

  Future<void> getSellingProducts() async {

    final result = await _repository.getShopProducts(
        getProductC2CStatus(ProductC2CStatus.public), shopId);

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data);
      meta = response.meta;
    }
      emit(_Initial(false, products));
    
  }

  void refresh(){
    getSellingProducts();
  }

  Future<void> loadmore() async {

    if (meta.page < meta.totalPages) {
      final result = await _repository.getShopProducts(
        getProductC2CStatus(ProductC2CStatus.public),
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
