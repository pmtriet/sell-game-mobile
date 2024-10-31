import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/compress_file.dart';
import '../../../post/domain/interface/post_repository_interface.dart';
import '../../infrastructure/model/post_model.dart';

part 'preview_state.dart';
part 'preview_cubit.freezed.dart';

class PreviewCubit extends Cubit<PreviewState> with CancelableBaseBloc<PreviewState>{
  PreviewCubit(this._repository)
      : super(const PreviewState.initial(false, null, false));
  final IPostRepository _repository;

  Future<void> post(PostModel post) async {

    emit(state.copyWith(isLoading: true));
    
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
      emit(const _Initial(false, null, true));
    }, (failure) {
       emit(_Initial(false, failure.message, false));
    });
  }
}
