import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../home/domain/interfaces/home_repository_interface.dart';
import '../../../home/infrastructure/models/category_models/category_model.dart';

part 'game_state.dart';
part 'game_cubit.freezed.dart';

class GameCubit extends Cubit<GameState> with CancelableBaseBloc<GameState>{
  final IHomeRepository _repository;
  CategoryModel? selected;
  List<CategoryModel>? categories = [];

  GameCubit(this._repository)
      : super(const GameState.initial(true, null, null)) {
    _init();
  }

  Future<void> _init() async {
    //get categories
    final resultCategories = await _repository.categories();
    categories = resultCategories.fold((success) => success, (failure) => null);
    emit(_Initial(false, categories, selected));
  }

  void selectDropdown(CategoryModel? item) {
    emit(_Initial(true, categories, selected));

    selected = item;
    emit(_Initial(false, categories, item));

  }

  CategoryModel? getSelectedCategory (){
    return selected;
  }
}
