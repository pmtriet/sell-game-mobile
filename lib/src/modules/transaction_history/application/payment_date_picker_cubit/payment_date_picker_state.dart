part of 'payment_date_picker_cubit.dart';

@freezed
class PaymentDatePickerState with _$PaymentDatePickerState {
  const factory PaymentDatePickerState.initial(
          DateTime start, DateTime end, bool? isValid, String? errorMessage) =
      _Initial;
}
