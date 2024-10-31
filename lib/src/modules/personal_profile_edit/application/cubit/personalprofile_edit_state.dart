part of 'personalprofile_edit_cubit.dart';

@freezed
class PersonalprofileEditState with _$PersonalprofileEditState {
  const factory PersonalprofileEditState.initial() = _Initial;
  const factory PersonalprofileEditState.loaded(User user) = _Loaded;
  const factory PersonalprofileEditState.editting() = _Editting;
  const factory PersonalprofileEditState.error(String error) = _Error;
  const factory PersonalprofileEditState.loading() = _Loading;
}
