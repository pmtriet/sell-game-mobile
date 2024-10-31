import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../utils/enum_transaction_type.dart';

extension TransactionTypeExtension on TransactionType {
  SvgPicture get icon {
    switch (this) {
      case TransactionType.recharge:
        return Assets.icons.recharge.svg();
      case TransactionType.purchase:
        return Assets.icons.purchase.svg();
      case TransactionType.withdraw:
        return Assets.icons.wallet.svg();
      case TransactionType.income:
        return Assets.icons.income.svg();
      case TransactionType.refund:
        return Assets.icons.refund.svg();
      default:
        return Assets.icons.coin.svg();
    }
  }

  String get text {
    switch (this) {
      case TransactionType.recharge:
        return S.current.recharge;
      case TransactionType.purchase:
        return S.current.purchase;
      case TransactionType.withdraw:
        return S.current.withdraw;
      case TransactionType.income:
        return S.current.income;
      case TransactionType.refund:
        return S.current.refund;
      default:
        return '';
    }
  }
}
