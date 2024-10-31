
import '../../../domain/entities/category.dart';

// part 'category_attribute_model.freezed.dart';
// part 'category_attribute_model.g.dart';

// @freezed
// class CategoryAttributeModel with _$CategoryAttributeModel implements CategoryAttribute {
//   const CategoryAttributeModel._();

//   const factory CategoryAttributeModel({
//     @Default('') String key,
//     @Default('') String title,
//     @Default('') String value,
//   }) = _CategoryAttributeModel;

//   factory CategoryAttributeModel.fromJson(dynamic json) => _$CategoryAttributeModelFromJson(json);
// }
class CategoryAttributeModel implements CategoryAttribute {
  @override
  String key;
  @override
  String title;
  String _value;

  CategoryAttributeModel({
    this.key = '',
    this.title = '',
    String value = '',
  }) : _value = value;

  @override
  String get value => _value;

  set value(String newValue) {
    _value = newValue;
  }

  factory CategoryAttributeModel.fromJson(Map<String, dynamic> json) {
    return CategoryAttributeModel(
      key: json['key'] ?? '',
      title: json['title'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'value': value,
    };
  }
}