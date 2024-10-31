import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/extensions/list_string_x.dart';
import '../../../../common/extensions/optional_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/compress_file.dart';
import '../../../../common/utils/validator.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../../home/infrastructure/models/category_models/category_model.dart';
import '../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';
import '../../../home/infrastructure/models/category_product_models/product_image_model.dart';
import '../../../preview/infrastructure/model/post_model.dart';
import '../../domain/interface/update_post_repository_interface.dart';
import '../../infrastructure/models/user_product_model.dart';

part 'update_post_state.dart';
part 'update_post_cubit.freezed.dart';

class UpdatePostCubit extends Cubit<UpdatePostState>
    with CancelableBaseBloc<UpdatePostState> {
  final IUpdatePostRepository _repository;
  UpdatePostCubit(this._repository) : super(const UpdatePostState.initial());

  Future<void> updatePost(PostModel updatePost, UserProductModel previousPost,
      List<String>? deletedImages) async {
    emit(const _Loading());
    

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
      emit(const _Success());
    }, (failure) {
      emit(_Error(failure.message));
    });
  }

  PostModel? validate(
      CategoryModel? category,
      List<File>? newImages,
      List<ProductImageModel>? selectedRemainingImages,
      String title,
      String price,
      List<CategoryAttributeModel>? attributes,
      String? rank,
      CategorySigninMethodModel? signInMethod,
      String description,
      String account,
      String password) {
    emit(const _Loading());

    int? sellingPrice = price.toNumber();

    if (category == null) {
      emit(_Error(S.current.error_select_category));
    } else if (newImages == null && selectedRemainingImages == null) {
      emit(_Error(S.current.error_post_image));
    } else if (newImages!.isEmpty && selectedRemainingImages!.isEmpty) {
      emit(_Error(S.current.error_post_image));
    } else if (title.trim().isEmpty) {
      emit(_Error(S.current.error_title));
    } else if (!Validator.isValidPostTitle(title)) {
      emit(_Error(S.current.error_title));
    } else if (price.isEmpty) {
      emit(_Error(S.current.error_null_price));
    } else if (sellingPrice == null) {
      emit(_Error(S.current.error_price));
    } else if (!Validator.isValidSellingPrice(sellingPrice)) {
      emit(_Error(
          '${S.current.error_invalid_price} ${AppConstants.maxSellingPrice.toNumberFormat()}${S.current.currency_unit}'));
    } else if (attributes == null) {
      emit(_Error(S.current.error_null_attribute));
    } else if (!hasValidAttributes(attributes)) {
      emit(_Error(S.current.error_null_attribute));
    } else if (signInMethod == null) {
      emit(_Error(S.current.error_sign_in_method));
    } else if (account.isEmpty) {
      emit(_Error(S.current.error_account_game));
    } else if (password.isEmpty) {
      emit(_Error(S.current.error_password_game));
    } else {
      final newAttributes = removeNullValueAttributes(attributes);

      final post = PostModel(
          category: category,
          title: title.trim(),
          images: newImages,
          price: sellingPrice,
          attributes: newAttributes,
          rank: rank,
          signInMethod: signInMethod,
          description: description.trim(),
          account: account,
          password: password);

      
      emit(const _Initial());
      return post;
    }
    return null;
  }

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
        deletedImages.isNotNull && deletedImages!.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool hasValidAttributes(List<CategoryAttributeModel> attributes) {
    bool allValuesAreEmpty =
        attributes.every((attribute) => attribute.value.isEmpty);
    return !allValuesAreEmpty;
  }

  List<CategoryAttributeModel> removeNullValueAttributes(
      List<CategoryAttributeModel> attributes) {
    return attributes.where((attribute) => attribute.value.isNotEmpty).toList();
  }

  // String convertListImageToString(List<String> images) {
  //   String stringImage = '[';
  //   for (int i = 0; i < images.length; i++) {
  //     stringImage += '"${images[i]}"';
  //     if (i != images.length - 1) {
  //       stringImage += ',';
  //     }
  //   }
  //   stringImage += ']';
  //   return stringImage;
  // }

  void onLoading() {
    emit(const _Loading());
  }

  void unLoading() {
    emit(const _Initial());
  }
}
