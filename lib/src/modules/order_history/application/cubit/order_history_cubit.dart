import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/interface/order_history_repository_interface.dart';
import '../../infrastucture/model/transaction_model.dart';

part 'order_history_state.dart';
part 'order_history_cubit.freezed.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final int transactionId;
  final IOrderHistoryRepository _repository; 
  
  OrderHistoryCubit(this.transactionId, this._repository) : super(const OrderHistoryState.loading()){
    getTransaction();
  }

  Future<void> getTransaction() async {
    final resultProducts = await _repository.transaction(transactionId);
    final transaction =
        resultProducts.fold((success) => success, (failure) => null);

    emit(_Loaded(transaction));
  }
}
