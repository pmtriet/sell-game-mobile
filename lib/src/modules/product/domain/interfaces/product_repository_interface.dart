import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../infrastructure/model/suggest_product_model.dart';

abstract class IProductRepository {
  Future<Result<ProductModel, ApiError>> productDetail(int id,
      {CancelToken? token});
  Future<Result<List<SuggestProductModel>, ApiError>> suggestProducts(int id,
      {CancelToken? token});
}
