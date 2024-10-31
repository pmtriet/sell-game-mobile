part of 'add_image_cubit.dart';

@freezed
class AddImageState with _$AddImageState {
  const factory AddImageState.initial(bool isLoading, List<ProductImageModel> selectedRemainingImages, List<File> newImages) = _Initial;
}
 