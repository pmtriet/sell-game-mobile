part of 'update_post_cubit.dart';

@freezed
class UpdatePostState with _$UpdatePostState {
    const factory UpdatePostState.initial() = _Initial;
  const factory UpdatePostState.error(String error) = _Error;
  const factory UpdatePostState.loading() = _Loading;
  const factory UpdatePostState.success() = _Success;
}
