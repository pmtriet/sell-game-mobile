part of 'category_game_cubit.dart';

@freezed
class CategoryGameState with _$CategoryGameState {
  const factory CategoryGameState.initial(bool isLoading, List<CategoryModel> category, CategoryModel? current, int? selected) = _Initial;
}
