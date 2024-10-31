import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../home/infrastructure/models/category_models/category_and_products_model.dart';

abstract class ICategoryRepository {
  Future<
      Result<ProductsByCategoryPagingApiResponse<CategoryAndProductsModel>,
          ApiError>> productsByCategory(
            String slug,
            String type, 
      {bool? saleOff,
      String? rank,
      String? title,
      String? price,
      int? minPrice,
      int? maxPrice,
      int? page,
      CancelToken? token});
}
