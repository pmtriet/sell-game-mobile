import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'payment_date_picker_state.dart';
part 'payment_date_picker_cubit.freezed.dart';

class PaymentDatePickerCubit extends Cubit<PaymentDatePickerState> with CancelableBaseBloc<PaymentDatePickerState>{
  DateTime start = DateTime.now().subtract(const Duration(days: 7));
  DateTime end = DateTime.now();

  PaymentDatePickerCubit()
      : super(PaymentDatePickerState.initial(
            DateTime.now().subtract(const Duration(days: 7)),
            DateTime.now(),
            null,
            null));

  void validateStartDate(DateTime newStart, DateTime start,DateTime end) {
    if (newStart.isAfter(end)) {
      emit(_Initial(start, end, null,  S.current.end_before_start));
    } else {
      emit(_Initial(newStart, end, true, null));
    }
  }

  void validateEndDate( DateTime newEnd, DateTime start, DateTime end) {
    if (newEnd.isBefore(start)) {
      emit(_Initial(start, end, null,  S.current.end_before_start));
    } else {
      emit(_Initial(start, newEnd, true, null));
    }
  }
}
