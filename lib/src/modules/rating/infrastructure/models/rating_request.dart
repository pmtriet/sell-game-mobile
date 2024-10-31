import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_request.freezed.dart';
part 'rating_request.g.dart';


@freezed
class RatingRequest with _$RatingRequest {
  const RatingRequest._();

  const factory RatingRequest({
    @Default(0) int productId,
    @Default(0) int star,
    String? content,
  }) = _RatingRequest;

  factory RatingRequest.fromJson(dynamic json) => _$RatingRequestFromJson(json);
}