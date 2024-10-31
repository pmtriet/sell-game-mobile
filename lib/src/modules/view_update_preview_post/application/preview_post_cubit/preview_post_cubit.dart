import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/extensions/list_string_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/compress_file.dart';
import '../../../preview/infrastructure/model/post_model.dart';
import '../../domain/interface/update_post_repository_interface.dart';
import '../../infrastructure/models/user_product_model.dart';

part 'preview_post_state.dart';
part 'preview_post_cubit.freezed.dart';

class PreviewPostCubit extends Cubit<PreviewPostState>
    with CancelableBaseBloc<PreviewPostState> {
  final IUpdatePostRepository _repository;
  PreviewPostCubit(this._repository)
      : super(const PreviewPostState.initial(false, null, false));

  Future<void> updatePost(PostModel updatePost, UserProductModel previousPost,
      List<String>? deletedImages) async {
    emit(state.copyWith(isLoading: true));

    if (!isEdited(updatePost, previousPost, deletedImages)) {
      emit(state.copyWith(isLoading: false, error: S.current.error_edit_post));
      return;
    }

    final multipartFiles = <MultipartFile>[];
    if (updatePost.images.isNotEmpty) {
      final List<File> compressedImages = [];

      //resize images
      for (final file in updatePost.images) {
        File compressImage = await compressFile(file);
        compressedImages.add(compressImage);
      }

      //convert images to list MultipartFile
      for (final file in compressedImages) {
        final fileBytes = await file.readAsBytes();
        final multipartFile = MultipartFile.fromBytes(
          fileBytes,
          filename: file.path.split('/').last,
          contentType: MediaType('image', '*'),
        );
        multipartFiles.add(multipartFile);
      }
    }

    final result = await _repository.updatePost(
      previousPost.id,
      title: updatePost.title != previousPost.title ? updatePost.title : null,
      description: updatePost.description != previousPost.description
          ? updatePost.description
          : null,
      loginAccount: updatePost.account != previousPost.productInfo.account
          ? updatePost.account
          : null,
      password: updatePost.password != previousPost.productInfo.password
          ? updatePost.password
          : null,
      rank: updatePost.rank != previousPost.rank ? updatePost.rank : null,
      price: updatePost.price != previousPost.price ? updatePost.price : null,
      attributes: updatePost.attributes,
      signInMethodId: updatePost.signInMethod.id != previousPost.signInMethod.id
          ? updatePost.signInMethod.id
          : null,
      images: updatePost.images.isNotEmpty ? multipartFiles : null,
      imagesToDelete: deletedImages?.toStringOfArrayWithSquareBrackets(),
    );
    return result.fold((success) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    }, (failure) {
      emit(state.copyWith(isLoading: false, error: failure.message));
    });
  }

  // TODO: refactor later
  bool isEdited(PostModel updatePost, UserProductModel previousPost,
      List<String>? deletedImages) {
    if (updatePost.title != previousPost.title) {
      return true;
    }
    if (updatePost.description != previousPost.description) {
      return true;
    }
    if (updatePost.account != previousPost.productInfo.account) {
      return true;
    }
    if (updatePost.password != previousPost.productInfo.password) {
      return true;
    }
    if (updatePost.rank != previousPost.rank) {
      return true;
    }
    if (updatePost.price != previousPost.price) {
      return true;
    }
    // attributes
    for (var oldAttribute in previousPost.attributes) {
      bool isNewAttribute = true;
      for (var newAttribute in updatePost.attributes) {
        isNewAttribute = true;
        if (oldAttribute.key == newAttribute.key) {
          isNewAttribute = false;
          if (oldAttribute.value != newAttribute.value) {
            return true;
          }
        }
      }
      if (isNewAttribute) {
        return true;
      }
    }
    if (updatePost.signInMethod.id != previousPost.signInMethod.id) {
      return true;
    }
    if (updatePost.images.isNotEmpty ||
        deletedImages != null && deletedImages.isNotEmpty) {
      return true;
    }
    return false;
  }
  // String convertListImageToString(List<String> selectedImages) {
  //   String stringImage = '[';
  //   for (int i = 0; i < selectedImages.length; i++) {
  //     stringImage += '"${selectedImages[i]}"';
  //     if (i != selectedImages.length - 1) {
  //       stringImage += ',';
  //     }
  //   }
  //   stringImage += ']';
  //   return stringImage;
  // }
}
