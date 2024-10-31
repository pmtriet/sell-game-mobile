part of 'view_post_cubit.dart';

@freezed
class ViewPostState with _$ViewPostState {
  const factory ViewPostState.initial(bool isLoading, UserProductModel? product, int? carouselIndex, bool? isDeletedSuccess, String? errorMessage) = _Initial;
}
 