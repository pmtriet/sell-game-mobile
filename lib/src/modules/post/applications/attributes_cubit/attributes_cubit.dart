import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';

part 'attributes_state.dart';
part 'attributes_cubit.freezed.dart';

class AttributesCubit extends Cubit<AttributesState> with CancelableBaseBloc<AttributesState>{
  AttributesCubit() : super(const AttributesState.initial(false, null));

  Map<CategoryAttributeModel, bool> attributes = {};

  void init(List<CategoryAttributeModel> newList) {
    emit(_Initial(true, attributes));

    clearAllAttributeValues();

    attributes = {for (var attribute in newList) attribute: false};

    emit(_Initial(false, attributes));
  }

  T? firstWhereOrNull<T>(Iterable<T> items, bool Function(T) test) {
    for (T item in items) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }

  void addAttributeValue(CategoryAttributeModel attribute, String value) {
    final matchingKey = firstWhereOrNull(
        attributes.keys, (element) => element.key == attribute.key);

    if (matchingKey != null) {
      matchingKey.value = value;
      attributes[matchingKey] = true;
    }
  }

  void onSelectAttribute(CategoryAttributeModel? attribute) {
    if (attribute != null &&
        attributes.containsKey(attribute) &&
        !(attributes[attribute]!)) {
      emit(_Initial(true, attributes));

      attributes[attribute] = true;

      emit(_Initial(false, attributes));
    }
  }

  void deleteAttribute(CategoryAttributeModel attribute) {
    final matchingKey = firstWhereOrNull(
        attributes.keys, (element) => element.key == attribute.key);

    if (matchingKey != null) {
      emit(_Initial(true, attributes));
      matchingKey.value = '';
      attributes[matchingKey] = false;
      emit(_Initial(false, attributes));
    }
  }

  List<CategoryAttributeModel>? getAttributes() {
    List<CategoryAttributeModel> list = [];
    attributes.forEach((key, value) {
      if (value == true) {
        list.add(key);
      }
    });
    return list;
  }

  void clearAllAttributeValues() {
    attributes.forEach((attribute, isSelected) {
      attribute.value = '';
    });
  }
}
