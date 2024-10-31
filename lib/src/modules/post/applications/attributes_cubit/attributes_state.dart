part of 'attributes_cubit.dart';

@freezed
class AttributesState with _$AttributesState {
  const factory AttributesState.initial(bool isLoading, Map<CategoryAttributeModel, bool>? attributes) = _Initial;
}
 