import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/constants/app_constants.dart';
import '../../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../home/infrastructure/models/category_product_models/product_image_model.dart';

part 'add_image_state.dart';
part 'add_image_cubit.freezed.dart';

class AddImageCubit extends Cubit<AddImageState>
    with CancelableBaseBloc<AddImageState> {
  final List<ProductImageModel> selectedImages;
  AddImageCubit(this.selectedImages)
      : super(const AddImageState.initial(false, [], [])) {
    currentLength = selectedImages.length;
    getFileName();
  }
  int currentLength = 0;
  List<ProductImageModel> selectedRemainingImages = [];
  List<File> newImages = [];
  List<String> deleteImages = [];

  void onSelectImage(File file) {
    if (currentLength < AppConstants.maxImagePost) {
      emit(state.copyWith(isLoading: true));

      newImages.add(file);
      ++currentLength;

      emit(_Initial(false, selectedRemainingImages, newImages));
    }
  }

  void onDeleteNewImage(File file) {
    emit(state.copyWith(isLoading: true));

    newImages.remove(file);
    --currentLength;

    emit(_Initial(false, selectedRemainingImages, newImages));
  }

  void onDeleteSelectedImage(ProductImageModel image) {
    emit(state.copyWith(isLoading: true));

    deleteImages.add(image.fileName);
    selectedRemainingImages.remove(image);
    --currentLength;

    emit(_Initial(false, selectedRemainingImages, newImages));
  }

  List<File>? getNewImages() {
    return newImages;
  }

  List<String>? getDeletedImages() {
    return deleteImages;
  }

  List<ProductImageModel>? getSelectedRemainingImages() {
    return selectedRemainingImages;
  }

  void getFileName() {
    for (var image in selectedImages) {
      selectedRemainingImages.add(image);
    }
    emit(state.copyWith(selectedRemainingImages: selectedRemainingImages));
  }
}
