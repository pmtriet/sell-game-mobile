part of 'post_cubit.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.error(String error) = _Error;
  const factory PostState.loading() = _Loading;
  const factory PostState.success() = _Success;
}
