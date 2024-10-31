import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/interface/rating_repository_interface.dart';
import '../../infrastructure/models/rating_request.dart';

part 'rating_state.dart';
part 'rating_cubit.freezed.dart';

class RatingCubit extends Cubit<RatingState> {
  final IRatingRepository _repository;
  final int productId;
  RatingCubit(this.productId, this._repository)
      : super(const RatingState.initial(false, null, null));

  int currentStar = 5;

  void onTapOnStarRating(int numberStar) {
    currentStar = numberStar;
  }

  Future<void> onRate(String? content) async {
    if (!isClosed) {
      emit(state.copyWith(isLoading: true));
    }

    var request = RatingRequest(
        productId: productId, star: currentStar, content: content);

    final result = await _repository.rating(request);

    result.fold((success) {
      if (!isClosed) {
        emit(const _Initial(false, null, true));
      }
    }, (failure) {
      if (!isClosed) {
        emit(_Initial(false, failure.message, false));
      }
    });
  }
}
