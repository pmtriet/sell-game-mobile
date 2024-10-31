import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/compress_file.dart';
import '../../../../common/utils/validator.dart';
import '../../../home/domain/entities/category.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';
import '../../../preview/infrastructure/model/post_model.dart';
import '../../domain/interface/post_repository_interface.dart';

part 'post_state.dart';
part 'post_cubit.freezed.dart';

class PostCubit extends Cubit<PostState> with CancelableBaseBloc<PostState> {
  final IPostRepository _repository;
  PostCubit(this._repository) : super(const PostState.initial());

  Future<void> post(PostModel post) async {
    emit(const _Loading());

    final multipartFiles = <MultipartFile>[];
    final List<File> compressedImages = [];

    //resize images
    for (final file in post.images) {
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

    final result = await _repository.post(
      post.title,
      post.description,
      post.account,
      post.password,
      post.rank,
      post.category.id,
      post.signInMethod.id,
      post.price,
      post.attributes,
      multipartFiles,
    );
    return result.fold((success) {
      emit(const _Success());
    }, (failure) {
      emit(_Error(failure.message));
    });
  }

  PostModel? validate(
      Category? category,
      List<File>? images,
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
    } else if (images == null) {
      emit(_Error(S.current.error_post_image));
    } else if (images.isEmpty) {
      emit(_Error(S.current.error_post_image));
    } else if (title.trim().isEmpty) {
      emit(_Error(S.current.error_title));
    } else if (!Validator.isValidPostTitle(title.trim())) {
      emit(_Error(S.current.error_title_length));
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
          images: images,
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

  bool hasValidAttributes(List<CategoryAttributeModel> attributes) {
    bool allValuesAreEmpty =
        attributes.every((attribute) => attribute.value.isEmpty);
    return !allValuesAreEmpty;
  }

  List<CategoryAttributeModel> removeNullValueAttributes(
      List<CategoryAttributeModel> attributes) {
    return attributes.where((attribute) => attribute.value.isNotEmpty).toList();
  }

  void setStateLoading(){
    emit(const _Loading());
  }
  void setStateInitial(){
    emit(const _Initial());
  }
}
