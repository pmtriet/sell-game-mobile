part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loaded(List<AppBanner> banners, List<Category> categories, List<ListSuggestingProductModel> products,  bool isLoading) = _Loaded;
}