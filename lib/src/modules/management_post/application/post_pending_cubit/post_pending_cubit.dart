import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_status_post.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/management_post_repository_interface.dart';

part 'post_pending_state.dart';
part 'post_pending_cubit.freezed.dart';

class PostPendingCubit extends Cubit<PostPendingState>
    with CancelableBaseBloc<PostPendingState> {
  final IManagementPostRepository _repository;
  PostPendingCubit(this._repository)
      : super(const PostPendingState.initial(true, null)) {
    getPendingProducts();
  }

  late MetaApiResponse meta;
  List<MarketplaceProductModel> products = [];

  Future<void> getPendingProducts() async {
    final result = await _repository
        .getProductsManagementPost(getPostStatus(PostStatus.pending));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(false, products));
  }

  void refresh() {
    getPendingProducts();
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.getProductsManagementPost(
        getPostStatus(PostStatus.pending),
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
