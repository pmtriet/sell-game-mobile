import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/mixin/cancelable_base_bloc.dart';
import '../../buy/infrastructor/models/category_product.dart';
import '../domain/interfaces/search_repository_interface.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> with CancelableBaseBloc<SearchState>{
  final ISearchRepository _repository;
  final _searchSubject = PublishSubject<String>();

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  String? keyword;
  bool saleOff = false;
  String price = 'desc'; // Price sorting
  String? rank;
  int page = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  SearchCubit(this._repository) : super(const SearchState.initial()) {
    _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((keyword) {

        searchProducts(keyword, page: 1, limit: 10); // Default page and limit
    });
  }

  // Add search term to stream
  void onSearchChanged(String keyword) {
    _searchSubject.add(keyword);
  }

  // Search products based on the keyword
  Future<void> searchProducts(String keyword,
      {int page = 1, int limit = 10}) async {
    emit(const SearchState.loading());

    final result =
        await _repository.searchProducts(keyword, page: page, limit: limit);

    result.fold(
      (products) {
        if (products.isEmpty) {
          emit(const SearchState.error('Không tìm thấy kết quả phù hợp'));
        } else {
          this.products = products;
          // emit(SearchState.loaded(products));
          hasMore = products.length >= limit;
          filteredProducts = List.from(
              products); // Initially, filtered products are the same as the search results
          emit(SearchState.loaded(filteredProducts));
        }
      },
      (error) {
        emit(SearchState.error(error.message));
      },
    );
  }

  // Initialize with a keyword
  Future<void> initializeSearch(
      String keyword, List<ProductModel> searchResults) async {
    this.keyword = keyword;
    products = searchResults;
    filteredProducts = List.from(products);
    emit(SearchState.loaded(filteredProducts));
  }

  // Filter by newest (e.g., sort by createdAt descending)
  Future<void> filterByNewest() async {
    emit(const SearchState.loading());

    price = 'asc'; // Default price sorting when filtering by newest
    saleOff = false; // Not sale-specific filter

    final result = await _repository.searchProducts(
      keyword ?? '',
      page: 1,
      saleOff: saleOff,
      price: price,
    );

    result.fold(
      (products) {
        this.products = products;
        filteredProducts = List.from(products);
        emit(SearchState.loaded(filteredProducts));
      },
      (error) {
        emit(SearchState.error(error.message));
      },
    );
  }

  // Filter by sale (products with discounts)
  Future<void> filterBySale() async {
    emit(const SearchState.loading());

    saleOff = true; // Filter only by sale products

    final result = await _repository.searchProducts(
      keyword ?? '',
      page: 1,
      saleOff: saleOff,
      price: price, // Sorting price is still considered
    );

    result.fold(
      (products) {
        this.products = products;
        filteredProducts = List.from(products);
        emit(SearchState.loaded(filteredProducts));
      },
      (error) {
        emit(SearchState.error(error.message));
      },
    );
  }

  // Filter by price low to high
  Future<void> filterByPriceLowToHigh() async {
    emit(const SearchState.loading());

    price = 'asc'; // Sort price low to high

    final result = await _repository.searchProducts(
      keyword ?? '',
      page: 1,
      saleOff: saleOff,
      price: price,
    );

    result.fold(
      (products) {
        this.products = products;
        filteredProducts = List.from(products);
        emit(SearchState.loaded(filteredProducts));
      },
      (error) {
        emit(SearchState.error(error.message));
      },
    );
  }

  // Filter by price high to low
  Future<void> filterByPriceHighToLow() async {
    emit(const SearchState.loading());

    price = 'desc'; // Sort price high to low

    final result = await _repository.searchProducts(
      keyword ?? '',
      page: 1,
      saleOff: saleOff,
      price: price,
    );

    result.fold(
      (products) {
        this.products = products;
        filteredProducts = List.from(products);
        emit(SearchState.loaded(filteredProducts));
      },
      (error) {
        emit(SearchState.error(error.message));
      },
    );
  }

  // Load more products when scrolling down
  Future<void> loadMore() async {
  if (isLoadingMore || !hasMore) return; // Prevent duplicate loads

  isLoadingMore = true;
  page += 1;

  final result = await _repository.searchProducts(
    keyword ?? '',
    page: page,
    saleOff: saleOff,
    price: price,
  );

  result.fold(
    (newProducts) {
      if (newProducts.isNotEmpty) {
        // Ensure products list is mutable
        products = List.from(products)..addAll(newProducts); 
        filteredProducts = List.from(products); 
        emit(SearchState.loaded(filteredProducts));

        hasMore = newProducts.length >= 10; // If less than limit, stop loading more
      } else {
        hasMore = false; // No more products to load
      }
    },
    (error) {
      emit(SearchState.error(error.message));
    },
  );

  isLoadingMore = false;
}

  @override
  Future<void> close() {
    _searchSubject.close();
    return super.close();
  }
}
