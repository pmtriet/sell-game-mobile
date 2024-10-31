import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../infrastructure/domain/interface/my_rating_repository_interface.dart';
import '../../infrastructure/models/buyer_rating_model.dart';

part 'buyer_rating_state.dart';
part 'buyer_rating_cubit.freezed.dart';

class BuyerRatingCubit extends Cubit<BuyerRatingState>
    with CancelableBaseBloc<BuyerRatingState> {
  final IMyRatingRepository _repository;
  BuyerRatingCubit(this._repository)
      : super(const BuyerRatingState.initial(true, null)) {
    fetch();
  }

  late MetaApiResponse meta;
  List<BuyerRatingModel> products = [];

  Future<void> fetch() async {
    final result = await _repository.buyerRating();

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
      final result = await _repository.buyerRating(
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
