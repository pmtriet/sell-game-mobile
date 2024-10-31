part of 'add_image_cubit.dart';

@freezed
class AddImageState with _$AddImageState {
  const factory AddImageState.initial(bool isLoading, List<File>? images) = _Initial;
}
