import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remove_diacritic/remove_diacritic.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../infrastructure/models/bank_model.dart';

part 'bank_search_state.dart';
part 'bank_search_cubit.freezed.dart';

class BankSearchCubit extends Cubit<BankSearchState>
    with CancelableBaseBloc<BankSearchState> {
  BankSearchCubit() : super(const BankSearchState.initial(true, null)) {
    _init();
    debounce();
  }

  final debounceSubject = BehaviorSubject<String>();

  late List<BankModel> banks = [];

  Future<void> _init() async {
    //read data from json file
    final String bankJsonString =
        await rootBundle.loadString('assets/data/bank.json');

    final Map<String, dynamic> bankJsonMap = json.decode(bankJsonString);

    List<BankModel> listBanks = bankJsonMap.entries.map((entry) {
      Map<String, dynamic> bankData = entry.value;
      return BankModel.fromJson(bankData);
    }).toList();

    banks = listBanks;
    emit(_Initial(false, banks));
  }

  Future<void> refresh() async {}

  Future<void> loadmore() async {
    if (isClosed) return;
  }

  Future<void> search(String? txt) async {
    emit(state.copyWith(isLoading: true));
    if (txt == null) {
      emit(_Initial(false, banks));
    } else if (txt.isEmpty) {
      emit(_Initial(false, banks));
    } else {
      List<BankModel> searchList = banks.where((bank) {
        return removeDiacritics(bank.name.toLowerCase())
                .contains(removeDiacritics(txt.toLowerCase())) ||
            removeDiacritics(bank.shortName.toLowerCase())
                .contains(removeDiacritics(txt.toLowerCase()));
      }).toList();
      emit(_Initial(false, searchList));
    }
  }

  void debounce() {
    debounceSubject
        .debounceTime(
            const Duration(milliseconds: AppConstants.debounceSearchTime))
        .listen((txt) {
      search(txt);
    });
  }

  void onSearchTextChanged(String text) {
    debounceSubject.add(text);
  }
}
