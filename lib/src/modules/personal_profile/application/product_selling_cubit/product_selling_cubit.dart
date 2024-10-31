import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_status_post.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/personal_profile_repository_interface.dart';

part 'product_selling_state.dart';
part 'product_selling_cubit.freezed.dart';

class ProductSellingCubit extends Cubit<ProductSellingState> with CancelableBaseBloc<ProductSellingState>{
  final IPersonalProfileRepository _repository;
  ProductSellingCubit(this._repository)
      : super(const ProductSellingState.initial(true, [])) {
    getSellingProducts();
  }

  late MetaApiResponse meta;
  List<MarketplaceProductModel> products = [];

  Future<void> getSellingProducts() async {
    final result = await _repository
        .getProductsManagementPost(getPostStatus(PostStatus.selling));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(false, products));
  }

  void refresh() {
    getSellingProducts();
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.getProductsManagementPost(
        getPostStatus(PostStatus.selling),
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
