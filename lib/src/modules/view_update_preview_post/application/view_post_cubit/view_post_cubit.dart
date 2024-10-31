import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../domain/interface/view_post_repository_interface.dart';
import '../../infrastructure/models/user_product_model.dart';

part 'view_post_state.dart';
part 'view_post_cubit.freezed.dart';

class ViewPostCubit extends Cubit<ViewPostState>
    with CancelableBaseBloc<ViewPostState> {
  final IViewPostRepository _repository;
  final int productId;
  ViewPostCubit(this.productId, this._repository)
      : super(const ViewPostState.initial(true, null, null, null, null)) {
    _init();
  }

  UserProductModel? product;
  Future<void> _init() async {
    final resultProducts = await _repository.postDetail(productId);
    final products =
        resultProducts.fold((success) => success, (failure) => null);
    emit(_Initial(false, products, 0, null, null));

    product = products;
  }

  Future<void> deletePost() async {
    emit(_Initial(true, product, 0, null, null));
    final resultProducts = await _repository.deletePost(productId);

    resultProducts.fold((success) => emit(_Initial(false, product, 0, true, null)),
        (failure) => emit(_Initial(false, product, 0, null, failure.message)));
  }

  void updateCarouselIndex(int newIndex) {
    emit(state.copyWith(carouselIndex: newIndex));
  }
}
