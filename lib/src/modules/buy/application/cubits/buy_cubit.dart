import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../infrastructor/models/category_product.dart';

import '../../infrastructor/repositories/buy_repository_interface.dart';
import 'buy_state.dart';

class BuyCubit extends Cubit<BuyState> with CancelableBaseBloc<BuyState> {
  final ProductModel product;
  final IBuyRepository buyRepository;
  String? voucherCode; // Store the voucher code

  BuyCubit(this.product, this.buyRepository) : super(const BuyState.loading()) {
    init();
  }

  void init() {
    emit(BuyState.loaded(product, null));
  }

  // Method to set voucher code
  void setVoucherCode(String code) {
    voucherCode = code;
  }

  Future<void> applyVoucherCode(
      String code, int productId, BuildContext context) async {
    final result = await buyRepository.findVoucher(code, productId);

    result.fold(
      (failure) {
        emit(BuyState.error(failure.message, timestamp: DateTime.now().millisecondsSinceEpoch));
      },
      (voucher) {
        final updatedProduct = product.copyWith(
          price: voucher.originalPrice,
          saleOff: voucher.priceReduced,
          finalPrice: voucher.finalPrice,
        );
        emit(BuyState.loaded(updatedProduct, code));
      },
    );
  }

  void clearVoucherCode() {
    voucherCode = null;
    emit(BuyState.loaded(product, null));
  }

  // Method to perform the purchase
  Future<void> makePurchase(BuildContext context) async {
    // emit(const BuyState.loading());

    final result = await buyRepository.purchase(product.id, voucherCode);

    result.fold(
      (failure) {
        emit(BuyState.error(failure.message, timestamp: DateTime.now().millisecondsSinceEpoch));
      },
      (success) async {
        final userResult = await buyRepository.profile();

        userResult.fold(
          (user) async {
            await Storage.setUser(user);
            if (context.mounted) {
              context.read<AuthCubit>().emitNewUser(user);
            }
          },
          (error) {},
        );
        emit(const BuyState.success());
      },
    );
  }
}
