import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';

part 'transaction_history_tabbar_state.dart';
part 'transaction_history_tabbar_cubit.freezed.dart';

class TransactionHistoryTabbarCubit
    extends Cubit<TransactionHistoryTabbarState> with CancelableBaseBloc<TransactionHistoryTabbarState>{
  TransactionHistoryTabbarCubit()
      : super(const _Initial(1));

  

  Future<void> onTapToPaymentTab() async {
    if (state.index != 2) {
      emit(const _Initial(2));
    }
  }

  Future<void> onTapToProductTab() async {
    if (state.index != 1) {
      emit(const _Initial(1));
    }
  }
}
