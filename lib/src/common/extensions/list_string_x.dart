extension ConvertToStringOfArray on List<String> {
  String? toStringOfArrayWithSquareBrackets() {
    String stringOfArray = '[';
    for (int i = 0; i < length; i++) {
      stringOfArray += '"${this[i]}"';
      if (i != length - 1) {
        stringOfArray += ',';
      }
    }
    stringOfArray += ']';
    return stringOfArray;
  }

  String? toStringOfArray() {
    String stringOfArray = '';
    for (int i = 0; i < length; i++) {
      stringOfArray += this[i];
      if (i != length - 1) {
        stringOfArray += ',';
      }
    }
    return stringOfArray;
  }
}
