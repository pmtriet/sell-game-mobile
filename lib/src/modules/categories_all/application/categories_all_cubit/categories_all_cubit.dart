import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../home/domain/entities/category.dart';
import '../../../home/domain/interfaces/home_repository_interface.dart';

part 'categories_all_state.dart';
part 'categories_all_cubit.freezed.dart';

@Injectable()
class CategoriesAllCubit extends Cubit<CategoriesAllState>
    with CancelableBaseBloc<CategoriesAllState> {
  final IHomeRepository _repository;
  List<Category>? categories = [];

  CategoriesAllCubit(this._repository)
      : super(const CategoriesAllState.initial(true, null)) {
    _init();
  }

  Future<void> _init() async {
    //get categories
    final resultCategories = await _repository.categories();
    final list = resultCategories.fold((success) => success, (failure) => null);

    categories = list;

    emit(_Initial(false, categories));
  }

  Future<void> refresh() async {
    _init();
  }

  Future<void> loadmore() async {}
}
