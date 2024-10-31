part of 'report_cubit.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState.initial(
      List<File> images, bool isLoading, bool? isSuccess, ReportError? error) = _Initial;
}
