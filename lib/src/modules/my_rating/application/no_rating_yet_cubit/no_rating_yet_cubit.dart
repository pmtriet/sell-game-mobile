import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../infrastructure/domain/interface/my_rating_repository_interface.dart';
import '../../infrastructure/models/no_rating_model.dart';

part 'no_rating_yet_state.dart';
part 'no_rating_yet_cubit.freezed.dart';

class NoRatingYetCubit extends Cubit<NoRatingYetState>
    with CancelableBaseBloc<NoRatingYetState> {
  final IMyRatingRepository _repository;
  NoRatingYetCubit(this._repository)
      : super(const NoRatingYetState.initial(true, null)) {
    fetch();
  }
  late MetaApiResponse meta;
  List<NoRatingModel> products = [];

  Future<void> fetch() async {
    final result = await _repository.productsToRate();

    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data);
      meta = response.meta;
    }
    if (!isClosed) {
      emit(_Initial(false, products));
    }
  }

  void refresh() {
    fetch();
  }

  Future<void> loadmore() async {
    if (isClosed) return;

    if (meta.page < meta.totalPages) {
      final result = await _repository.productsToRate(
        page: meta.page + 1,
      );

      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        products.addAll(List.of(response.data));

        meta = response.meta;

        if (!isClosed) {
          emit(_Initial(false, products));
        }
      }
    }
  }
}
