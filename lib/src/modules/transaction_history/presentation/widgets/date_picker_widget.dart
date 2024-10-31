part of '../pages/transaction_history_page.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget(
      {super.key,
      required this.start,
      required this.end,
      required this.isInOrderTab});
  final DateTime start;
  final DateTime end;
  final bool isInOrderTab;

  @override
  Widget build(BuildContext context) {
    void validateStartDate(DateTime newStartDate) {
      if (isInOrderTab) {
        context
            .read<OrderDatePickerCubit>()
            .validateStartDate(newStartDate, start, end);
      } else {
        context
            .read<PaymentDatePickerCubit>()
            .validateStartDate(newStartDate, start, end);
      }
    }

    void validateEndDate(DateTime newEndDate) {
      if (isInOrderTab) {
        context
            .read<OrderDatePickerCubit>()
            .validateEndDate(newEndDate, start, end);
      } else {
        context
            .read<PaymentDatePickerCubit>()
            .validateEndDate(newEndDate, start, end);
      }
    }

    bool isSameDate(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    Future<void> selectStartDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        switchToInputEntryModeIcon: null,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorName.primary,
              colorScheme: const ColorScheme.light(primary: ColorName.primary),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: (DateTime day) {
          if (isSameDate(day, start)) {
            if (!isSameDate(start, end)) {
              return false;
            }
          }
          return true;
        },
      );
      if (picked != null) {
        validateStartDate(picked);
      }
    }

    Future<void> selectEndDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        switchToInputEntryModeIcon: null,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorName.primary,
              colorScheme: const ColorScheme.light(primary: ColorName.primary),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: (DateTime day) {
          if (isSameDate(day, DateTime.now())) {
            return true;
          }

          if (isSameDate(day, end)) {
            if (!isSameDate(start, end)) {
              return false;
            }
          }
          return true;
        },
      );
      if (picked != null) {
        validateEndDate(picked);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        height: 48.w,
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.grey353535),
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icons.calendar.svg(),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => selectStartDate(context),
                    child: Text(
                      start.format(DateFormatType.ddMMyyyy),
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  Assets.icons.verticalLine.svg(),
                  TextButton(
                    onPressed: () => selectEndDate(context),
                    child: Text(
                      end.format(DateFormatType.ddMMyyyy),
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
