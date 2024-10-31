import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../../../home/infrastructure/models/category_product_models/product_attribute_model.dart';

part 'attribute_state.dart';
part 'attribute_cubit.freezed.dart';

class AttributeCubit extends Cubit<AttributeState> with CancelableBaseBloc<AttributeState>{
  final List<ProductAttributeModel> selectedAttributes;
  AttributeCubit(this.selectedAttributes)
      : super(const AttributeState.initial(false, {}));

  Map<CategoryAttributeModel, bool> attributes = {};

  void init(List<CategoryAttributeModel> newList) {
    emit(_Initial(true, attributes));

    clearAllAttributeValues();

    for (var attribute in newList) {
      bool isAdded = false;
      for (var selected in selectedAttributes) {
        if (selected.key == attribute.key) {
          isAdded = true;
          var i = CategoryAttributeModel(
              key: selected.key, title: selected.title, value: selected.value);
          attributes.addAll({i: true});
          break;
        }
      }
      if (!isAdded) {
        attributes.addAll({attribute: false});
      }
    }
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
