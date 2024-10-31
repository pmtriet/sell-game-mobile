part of 'preview_cubit.dart';

@freezed
class PreviewState with _$PreviewState {
  const factory PreviewState.initial(bool isLoading, String? error, bool isSuccess) = _Initial;
}
