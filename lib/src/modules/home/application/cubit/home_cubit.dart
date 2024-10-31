import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_product_type.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/category.dart';
import '../../domain/interfaces/home_repository_interface.dart';
import '../../infrastructure/models/category_models/category_model.dart';
import '../../infrastructure/models/suggesting_product_model/list_suggesting_products_model.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@singleton
class HomeCubit extends Cubit<HomeState> with CancelableBaseBloc<HomeState> {
  final IHomeRepository _repository;

  HomeCubit(this._repository)
      : super(const HomeState.loaded([], [], [], true)) {
    fetchData();
  }

  Future<void> fetchData() async {
    var storageUser = Storage.user;
    if (storageUser != null) {
      //refresh profile
      getIt<AuthCubit>().getProfile();
    }

    //get banners
    final resultBanners =
        await _repository.banners(getStringFromProductType(ProductType.b2c));
    List<AppBanner> banners =
        resultBanners.fold((success) => success, (failure) => []);

    //get categories
    final resultCategories = await _repository.categories();
    List<CategoryModel> categories =
        resultCategories.fold((success) => success, (failure) => []);

    //get products
    final resultProducts = await _repository
        .suggestingProducts(getStringFromProductType(ProductType.b2c));
    List<ListSuggestingProductModel> products =
        resultProducts.fold((success) => success, (failure) => []);

    emit(_Loaded(banners, categories, products, false));
  }

  Future<void> refreshListSuggestingProducts() async {
    emit(state.copyWith(isLoading: true));
    //get products
    final resultProducts = await _repository
        .suggestingProducts(getStringFromProductType(ProductType.b2c));
    List<ListSuggestingProductModel> products =
        resultProducts.fold((success) => success, (failure) => []);

    emit(state.copyWith(
      isLoading: false,
      products: List.from(products),
    ));
  }

  Future<void> refresh() async {
    fetchData();
  }

  void emitToLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void emitToUnLoading() {
    emit(state.copyWith(isLoading: false));
  }
}
