enum TransactionType {
  recharge,
  purchase,
  withdraw,
  income,
  refund,
  unknown
}

TransactionType getTransactionTypeFromString(String type) {
  switch (type) {
    case 'RECHARGE':
      return TransactionType.recharge;
    case 'PURCHASE':
      return TransactionType.purchase;
    case 'WITHDRAW':
      return TransactionType.withdraw;
    case 'INCOME':
      return TransactionType.income;
    case 'REFUND':
      return TransactionType.refund;
    default:
      return TransactionType.unknown;
  }
}