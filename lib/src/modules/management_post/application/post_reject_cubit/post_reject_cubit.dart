import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_status_post.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../../marketplace/infrastructure/models/marketplace_product_model.dart';
import '../../domain/interface/management_post_repository_interface.dart';

part 'post_reject_state.dart';
part 'post_reject_cubit.freezed.dart';

class PostRejectCubit extends Cubit<PostRejectState>
    with CancelableBaseBloc<PostRejectState> {
  final IManagementPostRepository _repository;
  PostRejectCubit(this._repository)
      : super(const PostRejectState.initial(true, null)) {
    getRejectProducts();
  }

  late MetaApiResponse meta;
  List<MarketplaceProductModel> products = [];

  Future<void> getRejectProducts() async {
    final result = await _repository
        .getProductsManagementPost(getPostStatus(PostStatus.rejected));

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(false, products));
  }

  void refresh() {
    getRejectProducts();
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.getProductsManagementPost(
        getPostStatus(PostStatus.rejected),
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
