part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial(String gameName, bool isLoading, List<CategoryProductModel>? products) = _Initial;

}
