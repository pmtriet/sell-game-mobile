part of 'game_cubit.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.initial(bool isLoading, List<CategoryModel>? category, CategoryModel? selectedGame) = _Initial;
}
