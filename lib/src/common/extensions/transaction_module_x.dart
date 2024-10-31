import '../../../generated/l10n.dart';

String convertTransactionStatusToString(String status) {
  switch (status) {
    case 'PENDING':
      return S.current.wait_comfirm;
    case 'DONE':
      return S.current.success;
    case 'FAILURE':
      return S.current.failure;
    case 'REFUND':
      return S.current.refund;
    default:
      return '';
  }
}
