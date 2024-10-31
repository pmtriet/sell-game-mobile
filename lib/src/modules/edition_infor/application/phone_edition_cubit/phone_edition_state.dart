part of 'phone_edition_cubit.dart';

@freezed
class PhoneEditionState with _$PhoneEditionState {
  const factory PhoneEditionState.initial() = _Initial;
  const factory PhoneEditionState.error(String message) = _Error;
  const factory PhoneEditionState.valid() = _Valid;
}
