part of 'preview_post_cubit.dart';

@freezed
class PreviewPostState with _$PreviewPostState {
  const factory PreviewPostState.initial(bool isLoading, String? error, bool isSuccess) = _Initial;
}
