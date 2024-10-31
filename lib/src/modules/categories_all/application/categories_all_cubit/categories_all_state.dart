part of 'categories_all_cubit.dart';

@freezed
class CategoriesAllState with _$CategoriesAllState {
  const factory CategoriesAllState.initial(bool isLoading, List<Category>? categories) = _Initial;
}
