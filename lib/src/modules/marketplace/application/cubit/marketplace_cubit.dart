import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../domain/interface/marketplace_repository_interface.dart';
import '../../infrastructure/models/marketplace_product_follow_shop_model.dart';

part 'marketplace_state.dart';
part 'marketplace_cubit.freezed.dart';

@singleton
class MarketplaceCubit extends Cubit<MarketplaceState>
    with CancelableBaseBloc<MarketplaceState> {
  final IMarketplaceRepository _repository;
  MarketplaceCubit(this._repository)
      : super(const MarketplaceState.initial(true, null, null)) {
    fetchData();
  }

  Future<void> fetchData() async {
    emit(state.copyWith(displayLoading: false));
    final resultProducts = await _repository.productFollowShop();
    final products =
        resultProducts.fold((success) => success, (failure) => null);

    emit(_Initial(false, products, null));
  }

  void emitToLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void emitToUnloading() {
    emit(state.copyWith(isLoading: false));
  }
}
