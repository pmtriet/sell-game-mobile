import 'package:intl/intl.dart';

extension MoneyFormat on int {
  String toVND() {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(this);
  }
}

extension IntX on int {
  String toPercent() {
    return '${toString()}%';
  }
}
