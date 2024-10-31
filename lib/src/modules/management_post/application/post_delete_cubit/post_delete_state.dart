part of 'post_delete_cubit.dart';

@freezed
class PostDeleteState with _$PostDeleteState {
  const factory PostDeleteState.initial(bool isLoading, List<MarketplaceProductModel>? products) = _Initial;
}
