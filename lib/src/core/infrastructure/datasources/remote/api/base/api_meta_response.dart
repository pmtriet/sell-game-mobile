import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_meta_response.freezed.dart';
part 'api_meta_response.g.dart';

@freezed
class MetaApiResponse with _$MetaApiResponse {
  const factory MetaApiResponse({
    required int total,
    required int page,
    required int limit,
    required int totalPages,
  }) = _MetaApiResponse;

  factory MetaApiResponse.fromJson(dynamic json) =>
      _$MetaApiResponseFromJson(json);
}