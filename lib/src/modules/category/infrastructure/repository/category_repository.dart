import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../home/infrastructure/models/category_models/category_and_products_model.dart';
import '../../domain/interface/category_repository_interface.dart';
import '../service/category_api.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepository implements ICategoryRepository {
  final CategoryApi _api;

  CategoryRepository(this._api);

  @override
  Future<
      Result<ProductsByCategoryPagingApiResponse<CategoryAndProductsModel>,
          ApiError>> productsByCategory(String slug, String type,
      {bool? saleOff,
      String? rank,
      String? title,
      String? price,
      int? minPrice,
      int? maxPrice,
      int? page,
      CancelToken? token}) async {
    return await _api
        .productsByCategory(slug, type, saleOff, rank, title, price, minPrice,
            maxPrice, page, token)
        .tryGet((response) => response);
  }
}
