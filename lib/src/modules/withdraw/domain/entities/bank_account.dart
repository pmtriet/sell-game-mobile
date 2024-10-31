import 'bank.dart';

abstract class BankAccount {
  int get id;
  String get nameOwn;
  String get bankNumber;
  String get bin;
  Bank? get bank;
}
