import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/constants/app_constants.dart';
import '../../../../common/utils/compress_file.dart';
import '../../../../common/utils/enum_report_reason.dart';
import '../../../../common/utils/validator.dart';
import '../../domain/report_repository_interface.dart';
import '../error/report_error.dart';

part 'report_state.dart';
part 'report_cubit.freezed.dart';

class ReportCubit extends Cubit<ReportState> {
  final int transactionId;
  final IReportRepository _repository;

  ReportCubit(this.transactionId, this._repository)
      : super(const ReportState.initial([], false, null, null));

  ReportReasonType reportReasonType = ReportReasonType.scamUser;
  List<File> images = [];

  void onSelectReportReasonType(ReportReasonType type) {
    reportReasonType = type;
  }

  void onSelectImage(File file) {
    if (images.length < AppConstants.maxImagePost) {
      emit(_Initial(images, true, null, null));
      images.add(file);
      emit(_Initial(images, false, null, null));
    }
  }

  void onDeleteImage(File file) {
    emit(_Initial(images, true, null, null));
    images.remove(file);
    emit(_Initial(images, false, null, null));
  }

  Future<void> validate(String content) async {
    emit(_Initial(images, true, null, null));
    if (Validator.isEmptyContent(content.trim())) {
      emit(_Initial(
          images, false, null, ReportError.other(S.current.error_report_reason_description)));
    } else if (images.isEmpty) {
      emit(_Initial(images, false, null, ReportError.other(S.current.error_post_image)));
    } else {
      report(content);
    }
  }

  Future<void> report(String content) async {
    final multipartFiles = <MultipartFile>[];
    final List<File> compressedImages = [];

    //resize images
    for (final file in images) {
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

    final result = await _repository.report(
      transactionId,
      getReportReason(reportReasonType),
      content,
      multipartFiles,
    );
    return result.fold((success) {
      emit(_Initial(images, false, true, null));
    }, (failure) {
      emit(_Initial(images, false, false, ReportError.apiResponse(failure.message)));
    });
  }

  void setStateLoading(bool isLoading){
    emit(state.copyWith(isLoading: isLoading));
  }
}
