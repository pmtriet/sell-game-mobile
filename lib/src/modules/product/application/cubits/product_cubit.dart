import 'package:bloc/bloc.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_suggest_product.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../domain/interfaces/product_repository_interface.dart';
import '../../infrastructure/model/suggest_product_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState>
    with CancelableBaseBloc<ProductState> {
  final int productId;
  final IProductRepository _productRepository;

  ProductModel? product;
  SuggestProductModel? shopProducts;
  SuggestProductModel? suggestProducts;

  ProductCubit(this.productId, this._productRepository)
      : super(const ProductState.loaded(true, null, null, null, null, null)) {
    fetchProductDetail();
  }

  Future<void> fetchProductDetail() async {
    try {
      final result = await _productRepository.productDetail(productId);
      result.fold((success) {
        product = success;
        emit(ProductState.loaded(false, success, null, null, 0, null));
        fetchSuggestProduct();
      }, (error) {
        emit(ProductState.loaded(false, null, null, null, 0, error.message));
      });
    } catch (e) {
      emit(ProductState.loaded(false, null, null, null, 0, e.toString()));
    }
  }

  Future<void> fetchSuggestProduct() async {
    // emit(state.copyWith(isLoading: true));

    final result = await _productRepository.suggestProducts(productId);
    result.fold((success) {
      for (var item in success) {
        if (getSuggestProductTypeFromString(item.title) ==
            SuggestProductType.shopProducts) {
          shopProducts = item;
        } else if (getSuggestProductTypeFromString(item.title) ==
            SuggestProductType.suggestProducts) {
          suggestProducts = item;
        }
      }
      emit(ProductState.loaded(
          false, product!, shopProducts, suggestProducts, 0, null));
    }, (error) {
      emit(ProductState.loaded(false, product!, null, null, 0, error.message));
    });
  }

  void updateCarouselIndex(int newIndex) {
    state.maybeWhen(
      loaded: (isLoading, product, sellerProducts, suggestProducts,
          carouselIndex, errorMessage) {
        emit(ProductState.loaded(
            false, product, sellerProducts, suggestProducts, newIndex, null));
      },
      orElse: () {},
    );
  }

  void emitToLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void emitToUnloading() {
    emit(state.copyWith(isLoading: false));
  }
}
