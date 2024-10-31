part of 'post_reject_cubit.dart';

@freezed
class PostRejectState with _$PostRejectState {
  const factory PostRejectState.initial(bool isLoading, List<MarketplaceProductModel>? products) = _Initial;
}
