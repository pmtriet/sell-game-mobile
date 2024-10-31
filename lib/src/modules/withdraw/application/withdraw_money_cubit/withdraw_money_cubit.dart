import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/validator.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../auth/domain/interfaces/auth_repository_interface.dart';
import '../../domain/interface/withdraw_repository_interface.dart';
import '../../domain/request_models/withdraw_request.dart';
import '../../infrastructure/models/bank_account_model.dart';
import '../../infrastructure/models/bank_model.dart';

part 'withdraw_money_state.dart';
part 'withdraw_money_cubit.freezed.dart';

@Injectable()
class WithdrawMoneyCubit extends Cubit<WithdrawMoneyState>
    with CancelableBaseBloc<WithdrawMoneyState> {
  final IWithdrawRepository _repository;
  final IAuthRepository _authRepository;

  WithdrawMoneyCubit(this._repository, this._authRepository)
      : super(const WithdrawMoneyState.initial(
            null, null, null, null, null, null, null, true)) {
    _initBankData();
    walletBanks();
  }

  List<BankAccountModel>? bankAccounts = [];
  BankAccountModel? activeBank;
  BankAccountModel? deleteBank;

  List<BankModel>? listBanks;

  int availableBalance = (Storage.user != null) ? Storage.user!.balance : 0;
  int numberRemaining = 0;

  Future<void> walletBanks() async {
    numberRemaining = 2;

    final result = await _repository.walletBanks();
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      bankAccounts = List.of(response);
      setBankData();
      if (bankAccounts!.isNotEmpty) {
        activeBank = bankAccounts![0];
      }
    }

    emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
        deleteBank, null, null, false));
  }

  void resetWalletBanks() {
    emit(state.copyWith(isLoading: true, error: null, success: null));
    walletBanks();
  }

  Future<void> deleteBankAccount(int walletId) async {
    emit(state.copyWith(isLoading: true, error: null, success: null));

    final result = await _repository.delete(walletId);
    result.fold((success) {
      deleteBank = null;
      bankAccounts?.removeWhere((account) => account.id == walletId);
      emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
          deleteBank, null, null, false));
    },
        (failure) => {
              emit(_Initial(availableBalance, numberRemaining, bankAccounts,
                  activeBank, deleteBank, failure.message, null, false))
            });
  }

  Future<void> withdraw(String amount) async {
    emit(state.copyWith(isLoading: true, error: null, success: null));

    int? parsedAmount;
    parsedAmount = amount.toNumber();
    parsedAmount ??= 0;

    if (Validator.isEmptyAmount(amount)) {
      emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
          deleteBank, S.current.enter_amount, null, false));
    } else if (state.bankAccounts == null) {
      emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
          deleteBank, S.current.select_bank, null, false));
    } else if (availableBalance < parsedAmount) {
      emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
          deleteBank, S.current.error_available_amount, null, false));
    } else {
      //call API withdraw
      try {
        final request =
            WithdrawRequest(wdAmount: parsedAmount, bankId: activeBank!.id);

        final result = await _repository.withdraw(request);
        result.fold((success) {
          //refresh profile
          final user = _authRepository.getProfile();
          user.fold((success) {
            emit(state.copyWith(isLoading: null, success: true, error: null));
          }, (error) {
            getIt<AuthCubit>().logout();
            emit(state.copyWith(
                isLoading: null,
                success: null,
                error: S.current.error_unexpected));
          });
        }, (failure) {
          emit(state.copyWith(
              isLoading: null, success: null, error: failure.message));
        });
      } catch (e) {
        emit(state.copyWith(
            isLoading: null, success: null, error: S.current.error_unexpected));
      }
    }
  }

  void onPressedBankAccount(BankAccountModel account) {
    //remove delete bank
    deleteBank = null;

    if (account != activeBank) {
      activeBank = account;
    }
    emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
        deleteBank, null, null, false));
  }

  void onLongPressedBankAccount(BankAccountModel account) {
    //call api success
    //select to new bank
    if (account != deleteBank) {
      deleteBank = account;

      //delete active bank
      if (account == activeBank) {
        //active bank is first
        if (bankAccounts?[0] == account) {
          //set active bank is second
          if (bankAccounts!.length > 1) {
            activeBank = bankAccounts?[1];
          } else {
            activeBank = null;
          }
        }
        //active bank is not first
        else {
          //set active bank is first
          activeBank = bankAccounts?[0];
        }
      }
    }
    //select to delete bank
    else {
      deleteBank = null;
    }
    emit(_Initial(availableBalance, numberRemaining, bankAccounts, activeBank,
        deleteBank, null, null, false));
  }

  Future<void> _initBankData() async {
    //read data from json file
    final String bankJsonString =
        await rootBundle.loadString('assets/data/bank.json');

    final Map<String, dynamic> bankJsonMap = json.decode(bankJsonString);

    listBanks = bankJsonMap.entries.map((entry) {
      Map<String, dynamic> bankData = entry.value;
      return BankModel.fromJson(bankData);
    }).toList();
  }

  void setBankData() {
    for (int i = 0; i < bankAccounts!.length; i++) {
      var account = bankAccounts![i];

      var matchingBank = listBanks!.firstWhere(
        (bank) => bank.bin == account.bin,
        orElse: () => const BankModel(),
      );

      bankAccounts![i] = account.copyWith(bank: matchingBank);
    }
  }
}
