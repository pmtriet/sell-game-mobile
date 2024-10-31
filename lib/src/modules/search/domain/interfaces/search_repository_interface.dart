import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../buy/infrastructor/models/category_product.dart';


abstract class ISearchRepository {
  Future<Result<List<ProductModel>, ApiError>> searchProducts(
      String keyword, {int page = 1, int limit = 10, bool? saleOff,
    String? price,
    String? rank, CancelToken? token});
}
