import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_status_model.freezed.dart';
part 'post_status_model.g.dart';

@freezed
class PostStatusModel with _$PostStatusModel{
  const PostStatusModel._();

  const factory PostStatusModel({
    @Default('') String status,
    @Default(0) int count,
  }) = _PostStatusModel;

  factory PostStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PostStatusModelFromJson(json);
}
