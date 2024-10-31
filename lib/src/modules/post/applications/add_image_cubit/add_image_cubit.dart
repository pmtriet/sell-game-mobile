import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'add_image_state.dart';
part 'add_image_cubit.freezed.dart';

class AddImageCubit extends Cubit<AddImageState> with CancelableBaseBloc<AddImageState>{
  AddImageCubit() : super(const AddImageState.initial(false, null));

  List<File> images = [];

  void onSelectImage(File file) {
    if (images.length < AppConstants.maxImagePost) {
      emit(_Initial(true, images));

      images.add(file);

      emit(_Initial(false, images));
    }
  }

  void onDeleteImage(File file) {
    emit(_Initial(true, images));

    images.remove(file);

    emit(_Initial(false, images));
  }

  List<File>? getImages(){
    return images;
  }
}
