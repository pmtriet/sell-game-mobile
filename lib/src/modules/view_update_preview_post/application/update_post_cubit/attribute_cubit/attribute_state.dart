part of 'attribute_cubit.dart';

@freezed
class AttributeState with _$AttributeState {
  const factory AttributeState.initial(bool isLoading, Map<CategoryAttributeModel, bool> attributes) = _Initial;
}
