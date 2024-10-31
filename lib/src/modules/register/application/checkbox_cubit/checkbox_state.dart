part of 'checkbox_cubit.dart';

@freezed
class CheckboxState with _$CheckboxState {
  const factory CheckboxState.checked() = _Checked;
  const factory CheckboxState.unchecked() = _Unchecked;
}
