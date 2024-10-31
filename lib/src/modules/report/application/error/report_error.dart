import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_error.freezed.dart';

@freezed
class ReportError with _$ReportError {
  const factory ReportError.apiResponse(String message) = _ApiResponseError;
  const factory ReportError.other(String message) = _OtherError;
}
