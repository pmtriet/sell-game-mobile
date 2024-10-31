part of 'post_pending_cubit.dart';

@freezed
class PostPendingState with _$PostPendingState {
  const factory PostPendingState.initial(bool isLoading, List<MarketplaceProductModel>? products) = _Initial;
}
