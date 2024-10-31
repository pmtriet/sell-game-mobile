part of 'saved_post_cubit.dart';

@freezed
class SavedPostState with _$SavedPostState {
  const factory SavedPostState.initial(bool isLoading, List<SavedPostModel> posts, String? errorMessage) = _Initial;
}
