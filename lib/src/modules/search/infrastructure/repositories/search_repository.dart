import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../domain/interfaces/search_repository_interface.dart';
import '../services/search_api.dart';

@LazySingleton(as: ISearchRepository)
class SearchRepository implements ISearchRepository {
  final SearchApi _api;

  SearchRepository(this._api);

  @override
  Future<Result<List<ProductModel>, ApiError>> searchProducts(
    String keyword, {
    int page = 1,
    int limit = 10,
    bool? saleOff,
    String? price,
    String? rank,
    CancelToken? token,
  }) async {
    return await _api
        .searchProducts(page, limit, keyword, saleOff, price, rank, token)
        .tryGet((response) => response.data);
  }
}
