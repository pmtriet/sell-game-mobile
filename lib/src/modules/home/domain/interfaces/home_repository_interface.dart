import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../infrastructure/models/category_models/category_and_products_model.dart';
import '../../infrastructure/models/category_models/category_model.dart';
import '../../infrastructure/models/suggesting_product_model/list_suggesting_products_model.dart';
import '../entities/banner.dart';

abstract class IHomeRepository {
  Future<Result<List<AppBanner>, ApiError>> banners(String type, {CancelToken? token});
  Future<Result<List<CategoryModel>, ApiError>> categories({CancelToken? token});
  Future<Result<CategoryAndProductsModel, ApiError>> productsByCategory(
    String type,
      {CancelToken? token});
  Future<Result<List<ListSuggestingProductModel>, ApiError>> suggestingProducts(
    String type,
      {CancelToken? token});
}
