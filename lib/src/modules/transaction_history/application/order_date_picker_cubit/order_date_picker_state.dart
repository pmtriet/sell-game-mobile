part of 'order_date_picker_cubit.dart';

@freezed
class OrderDatePickerState with _$OrderDatePickerState {
  const factory OrderDatePickerState.initial(DateTime start, DateTime end, bool? isValid, String? errorMessage) = _Initial;
}
