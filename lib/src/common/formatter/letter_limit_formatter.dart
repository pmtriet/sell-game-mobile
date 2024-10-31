import 'package:flutter/services.dart';

class LetterLimitFormatter extends TextInputFormatter {
  final int maxLetters;

  LetterLimitFormatter(this.maxLetters);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > maxLetters) {
      String truncatedText = newValue.text.substring(0, maxLetters);
      return TextEditingValue(
        text: truncatedText,
        selection: TextSelection.collapsed(offset: truncatedText.length),
      );
    }

    return newValue;
  }
}
