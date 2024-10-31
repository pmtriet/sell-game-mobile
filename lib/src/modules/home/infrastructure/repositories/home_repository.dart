import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interfaces/home_repository_interface.dart';
import '../models/banner_models/banner_model.dart';
import '../models/category_models/category_and_products_model.dart';
import '../models/category_models/category_model.dart';
import '../models/suggesting_product_model/list_suggesting_products_model.dart';
import '../service/home_api.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final HomeApi _api;

  HomeRepository(this._api);

  @override
  Future<Result<List<BannerModel>, ApiError>> banners(
    String type,
      {CancelToken? token}) async {
    return await _api.banners(type, token).tryGet((response) => response.data);
  }

  @override
  Future<Result<List<CategoryModel>, ApiError>> categories(
      {CancelToken? token}) async {
    return await _api.categories(token).tryGet((response) => response.data);
  }

  @override
  Future<Result<CategoryAndProductsModel, ApiError>> productsByCategory(
      String type,
      {CancelToken? token}) async {
    return await _api
        .productsByCategory(type, token)
        .tryGet((response) => response.data);
  }

  @override
  Future<Result<List<ListSuggestingProductModel>, ApiError>> suggestingProducts(String type, {CancelToken? token}) async {
    return await _api
        .suggestingProducts(type, token)
        .tryGet((response) => response.data);
  }
}
