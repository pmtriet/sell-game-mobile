import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/validator.dart';
import '../../domain/interface/withdraw_repository_interface.dart';
import '../../infrastructure/models/bank_account_model.dart';
import '../../infrastructure/models/bank_model.dart';

part 'bank_edition_state.dart';
part 'bank_edition_cubit.freezed.dart';

@lazySingleton
class BankEditionCubit extends Cubit<BankEditionState> with CancelableBaseBloc<BankEditionState>{
  final IWithdrawRepository _repository;
  BankEditionCubit(this._repository)
      : super(const BankEditionState.initial(null, null, null, false));

  BankModel? selectedBank;

  void selectBank(BankModel bank) {
    selectedBank = bank;
    emit(_Initial(selectedBank, null, null, null));
  }

  Future<void> clickButton(
      String cardNumber, String cardHolderName, BankModel bank) async {
    emit(state.copyWith(isLoading: true));

    if (Validator.isEmptyCardNumber(cardNumber)) {
      emit(_Initial(
          selectedBank, S.current.enter_bank_account_number, null, null));
    } else if (Validator.isEmptyCardHolderName(cardHolderName)) {
      emit(_Initial(selectedBank, S.current.enter_name, null, null));
    } else {
      final request = BankAccountModel(
        nameOwn: cardHolderName,
        bankNumber: cardNumber,
        bin: selectedBank!.bin,
        bank: selectedBank!,
      );
      //call api create wallet
      final result = await _repository.createWallet(request);
      result.fold((success) {
        emit(_Initial(
            selectedBank,
            null,
            BankAccountModel(
              nameOwn: cardHolderName,
              bankNumber: cardNumber,
              bin: selectedBank!.bin,
              bank: selectedBank!,
            ),
            null));
      }, (failure) {
        emit(_Initial(selectedBank, failure.message, null, null));
      });
    }
  }

  void clear() {
    selectedBank = null;
    emit(const _Initial(null, null, null, null));
  }
}
