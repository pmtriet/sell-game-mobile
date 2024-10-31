extension DoubleX on double {
  String toPercent() {
    return isInt() ? '${round().toString()}%' : '${toString()}%';
  }

  bool isInt() {
    return (this % 1) == 0;
  }
}
