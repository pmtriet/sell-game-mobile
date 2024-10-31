import 'package:freezed_annotation/freezed_annotation.dart';
import '../../buy/infrastructor/models/category_product.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded(List<ProductModel>? products) = _Loaded;
  const factory SearchState.error(String? message) = _Error;
  const factory SearchState.detail(String? keyword, bool? isLoading, List<ProductModel>? products) = _Detail;
}
