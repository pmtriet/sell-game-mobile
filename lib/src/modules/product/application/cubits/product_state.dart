import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../buy/infrastructor/models/category_product.dart';
import '../../infrastructure/model/suggest_product_model.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  // const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(bool isLoading, ProductModel? product, SuggestProductModel? sellerProducts, SuggestProductModel? suggestProducts, int? carouselIndex, String? errorMessage) = _Loaded;
  // const factory ProductState.error(String message) = _Error;
}
