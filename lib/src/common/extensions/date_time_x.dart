import 'package:intl/intl.dart';

enum DateFormatType { hhmmddMMyy, yyyyMMdd, ddMMyyyy }


extension DateTimeX on DateTime {
  String format(DateFormatType type) {
    switch (type) {
    case DateFormatType.hhmmddMMyy:
      return DateFormat('HH:mm dd/MM/yy').format(this);
    case DateFormatType.yyyyMMdd:
      return DateFormat('yyyy-MM-dd').format(this);
    case DateFormatType.ddMMyyyy:
      return DateFormat('dd-MM-yyyy').format(this);
    default:
      return toString();
    }
  }
}
