part of 'post_public_cubit.dart';

@freezed
class PostPublicState with _$PostPublicState {
  const factory PostPublicState.initial(bool isLoading, List<MarketplaceProductModel>? products) = _Initial;
}
