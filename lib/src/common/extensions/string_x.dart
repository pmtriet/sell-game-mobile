import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../utils/utils.dart';

extension StringNumberFormat on int {
  String toNumberFormat() {
    return NumberFormat('#,##0').format(this);
  }
}

extension DurationFormat on String {
  String toDurationFormat() {
    DateTime inputTime = DateTime.parse(this);
    Duration difference = DateTime.now().difference(inputTime);
    if (difference.inDays ~/ 365 > 0) {
      return '${difference.inDays ~/ 365} ${S.current.year_before}';
    } else if (difference.inDays ~/ 30 > 0) {
      return '${difference.inDays ~/ 30} ${S.current.month_before}';
    }
    // else if (difference.inDays ~/ 7 > 0) {
    //   return '${difference.inDays ~/ 7} ${S.current.week_before}';
    // }
    else if (difference.inDays > 0) {
      return '${difference.inDays} ${S.current.day_before}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${S.current.hour_before}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${S.current.min_before}';
    } else if (difference.inMinutes == 0) {
      return S.current.up_now;
    } else {
      return 'Vừa xong';
    }
  }
}

extension DaysUntilNow on String {
  String toDurationInDaysUntilNow() {
    try {
      DateTime inputTime = DateTime.parse(this);
      DateTime newTime = inputTime.subtract(const Duration(days: 1));
      Duration difference = DateTime.now().difference(newTime);
      return difference.inDays.toString();
    } catch (e) {
      return '';
    }
  }
}

extension HidePhoneFormat on String {
  String toHidePhoneFormat() {
    if (length < 2) {
      return this;
    }
    final visiblePart = substring(length - 2);
    final hiddenPart = '*' * (length - 2);
    return hiddenPart + visiblePart;
  }
}

extension HideEmailFormat on String {
  String toHideEmailFormat() {
    final parts = split('@');

    if (parts.length != 2) {
      return this;
    }

    final namePart = parts[0];
    final domainPart = parts[1];

    if (namePart.length <= 2) {
      return '*${namePart.substring(1)}@$domainPart';
    }

    final firstChar = namePart[0];
    final lastChar = namePart[namePart.length - 1];
    final hiddenPart = '*' * (namePart.length - 2);

    return '$firstChar$hiddenPart$lastChar@$domainPart';
  }
}

extension BankAccountNumberFormat on String {
  String toBankAccountNumberFormat(
      {int blockSize = 4, String separator = ' '}) {
    String newText = replaceAll(' ', '');

    String formattedText = '';

    for (int i = 0; i < newText.length; i++) {
      formattedText += newText[i];
      if ((i + 1) % blockSize == 0 && i + 1 != newText.length) {
        formattedText += separator;
      }
    }
    return formattedText;
  }
}

extension MoneyFormat on String {
  String toMonneyFormat() {
    //remove 0 in prefix string
    String normalized = replaceFirst(RegExp(r'^0+'), '');
    if (normalized.isEmpty) return '0';

    if (normalized.length <= 3) return normalized;

    StringBuffer formatted = StringBuffer();
    int counter = 0;

    for (int i = normalized.length - 1; i >= 0; i--) {
      formatted.write(normalized[i]);
      counter++;

      if (counter == 3 && i != 0) {
        formatted.write('.');
        counter = 0;
      }
    }

    return formatted.toString().split('').reversed.join('');
  }
}

extension DateTimeParsing on String {
  String toDateTimeFormat() {
    try {
      DateTime dateTime = DateTime.parse(this);
      final convertedDate = dateTime.toLocal();

      String formattedDate =
          '${toTwoDigitsUtil(convertedDate.hour)}:${toTwoDigitsUtil(convertedDate.minute)} '
          '${toTwoDigitsUtil(convertedDate.day)}/${toTwoDigitsUtil(convertedDate.month)}/${convertedDate.year}';

      return formattedDate;
    } catch (e) {
      return this;
    }
  }
}

extension ToIntFormat on String {
  int? toNumber() {
    final sanitizedNumber = replaceAll('.', '');

    int? number;
    try {
      number = int.tryParse(sanitizedNumber);
      return number;
    } catch (e) {
      return null;
    }
  }
}
