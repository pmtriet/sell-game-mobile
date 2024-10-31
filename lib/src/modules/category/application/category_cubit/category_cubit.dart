import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/extensions/list_string_x.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/enum_product_type.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../../home/domain/entities/category.dart';
import '../../../home/infrastructure/models/category_product_models/product_model.dart';
import '../../domain/interface/category_repository_interface.dart';
import '../../infrastructure/models/filter_option_model.dart';
import '../../infrastructure/models/filter_price_rank_model.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState>
    with CancelableBaseBloc<CategoryState> {
  final ICategoryRepository _repository;
  final Category category;

  List<CategoryProductModel> products = [];
  late MetaApiResponse meta;

  late FilterOptionModel currentFilter;
  bool saleOff = false;
  String price = 'asc';
  String type = getStringFromProductType(ProductType.b2c);
  List<String>? rank;
  int? minPrice;
  int? maxPrice;
  String? searchTxt;

  final debounceSubject = BehaviorSubject<String>();

  CategoryCubit(this.category, this._repository)
      : super(CategoryState.initial(category.name, true, null)) {
    init();
    debounce();
  }

  Future<void> init() async {
    //filter by newest and price from low to high
    currentFilter = FilterOptionModel(
      filterByNewest: true,
      filterBySale: null,
      filterByPrice: true,
      filterByPriceRankModel: null,
    );
    //call api
    final result = await _repository.productsByCategory(category.slug, type);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);
      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> refresh() async {
    //call api
    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);
      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      //call api
      final result = await _repository.productsByCategory(category.slug, type,
          saleOff: saleOff,
          rank: rank?.toStringOfArray(),
          title: searchTxt,
          price: price,
          minPrice: minPrice,
          maxPrice: maxPrice,
          page: meta.page + 1);
      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        products.addAll(List.of(response.data.products));

        meta = response.meta;
        emit(CategoryState.initial(category.name, false, products));
      } else {
        emit(CategoryState.initial(category.name, false, null));
      }
    }
  }

  Future<void> filterByNewest() async {
    emit(state.copyWith(isLoading: true));
    //change sale to newest
    currentFilter.filterByNewest = true;
    currentFilter.filterBySale = null;

    saleOff = false;

    //call api
    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> filterBySale() async {
    emit(state.copyWith(isLoading: true));
    //change newest to sale
    currentFilter.filterByNewest = null;
    currentFilter.filterBySale = true;

    saleOff = true;

    //call api
    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> filterByPriceLowToHigh() async {
    emit(state.copyWith(isLoading: true));

    //change price filter
    currentFilter.filterByPrice = true;

    price = 'asc';

    //call api
    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> filterByPriceHighToLow() async {
    emit(CategoryState.initial(category.name, true, products));
    //change price filter
    currentFilter.filterByPrice = false;

    price = 'desc';

    //call api
    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> filterByRank(FilterPriceRankModel priceRankModel) async {
    emit(state.copyWith(isLoading: true));

    rank = priceRankModel.rankNames;
    minPrice = priceRankModel.minPrice;
    maxPrice = priceRankModel.maxPrice;

    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> removeFilter() async {
    emit(state.copyWith(isLoading: true));

    rank = null;
    minPrice = null;
    maxPrice = null;

    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
    }
  }

  Future<void> search(String? txt) async {
    emit(state.copyWith(isLoading: true));

    searchTxt = txt;

    final result = await _repository.productsByCategory(category.slug, type,
        saleOff: saleOff,
        rank: rank?.toStringOfArray(),
        title: searchTxt,
        price: price,
        minPrice: minPrice,
        maxPrice: maxPrice);
    final response = result.fold((success) => success, (failure) => null);

    if (response != null) {
      products = List.of(response.data.products);

      meta = response.meta;
      emit(CategoryState.initial(category.name, false, products));
    } else {
      emit(CategoryState.initial(category.name, false, null));
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
