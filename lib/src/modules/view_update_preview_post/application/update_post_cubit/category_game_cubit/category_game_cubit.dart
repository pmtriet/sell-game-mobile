import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../home/domain/interfaces/home_repository_interface.dart';
import '../../../../home/infrastructure/models/category_models/category_model.dart';

part 'category_game_state.dart';
part 'category_game_cubit.freezed.dart';

class CategoryGameCubit extends Cubit<CategoryGameState> with CancelableBaseBloc<CategoryGameState>{
  final IHomeRepository _repository;
  int? selectedId;
  CategoryModel? current;
  List<CategoryModel> categories = [];
  
  CategoryGameCubit(this._repository, this.selectedId) : super(const CategoryGameState.initial(true, [], null, null)){
    _init();
  }
  Future<void> _init() async {
    //get categories
    final resultCategories = await _repository.categories();
    categories = resultCategories.fold((success) => success, (failure) => []);
    
    for(var category in categories){
      if(category.id == selectedId){
        current = category;
      }
    }

    emit(_Initial(false, categories,current, selectedId));
  }

  CategoryModel? getCurrentCategory (){
    return current;
  }
}
