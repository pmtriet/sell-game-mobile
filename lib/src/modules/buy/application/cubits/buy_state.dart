// part of 'buy_cubit.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructor/models/category_product.dart';

part 'buy_state.freezed.dart';

@freezed
class BuyState with _$BuyState {
  const factory BuyState.loading() = _Loading;
  const factory BuyState.loaded(ProductModel product, String? appliedVoucherCode,) = _Loaded;
  const factory BuyState.error(String message, {required int timestamp}) = _Error;
  const factory BuyState.success() = _Success;
}

