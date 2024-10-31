part of 'name_edition_cubit.dart';

@freezed
class NameEditionState with _$NameEditionState {
  const factory NameEditionState.initial() = _Initial;
  const factory NameEditionState.loading() = _Loading;
  const factory NameEditionState.success() = _Success;
  const factory NameEditionState.error(String message) = _Error;
}
