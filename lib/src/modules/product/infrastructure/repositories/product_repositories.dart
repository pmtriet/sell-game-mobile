import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';

import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';

import '../../domain/interfaces/product_repository_interface.dart';
import '../model/suggest_product_model.dart';
import '../services/product_api.dart';

@LazySingleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  final ProductApi _api;

  ProductRepository(this._api);

  @override
  Future<Result<ProductModel, ApiError>> productDetail(int id,
      {CancelToken? token}) async {
    return await _api
        .productDetail(id, token)
        .tryGet((response) => response.data);
  }

  @override
  Future<Result<List<SuggestProductModel>, ApiError>> suggestProducts(int id, {CancelToken? token}) async {
    return await _api
        .suggestProducts(id, token)
        .tryGet((response) => response.data);
  }
}
