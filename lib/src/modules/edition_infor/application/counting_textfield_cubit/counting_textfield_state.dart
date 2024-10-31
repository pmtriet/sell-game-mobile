part of 'counting_textfield_cubit.dart';

@freezed
class CountingTextfieldState with _$CountingTextfieldState {
  const factory CountingTextfieldState.initial() = _Initial;
  const factory CountingTextfieldState.counting(int count) = _Counting;
  const factory CountingTextfieldState.resend() = _Resend;
}
