import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../infrastructure/domain/interface/my_rating_repository_interface.dart';
import '../../infrastructure/models/rated_model.dart';

part 'rated_state.dart';
part 'rated_cubit.freezed.dart';

class RatedCubit extends Cubit<RatedState> with CancelableBaseBloc<RatedState> {
  final IMyRatingRepository _repository;
  RatedCubit(this._repository) : super(const RatedState.initial(true, null)) {
    fetch();
  }

  late MetaApiResponse meta;
  List<RatedModel> products = [];

  Future<void> fetch() async {
    final result = await _repository.ratedProducts();

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
      final result = await _repository.ratedProducts(
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
