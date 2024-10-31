import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';

part 'post_api.g.dart';

@RestApi()
@injectable
abstract class PostApi {
  @factoryMethod
  factory PostApi(Dio dio) = _PostApi;

  @POST('/v1/products')
  @MultiPart()
  Future<StatusApiResponse> post(
    @Part(name: 'title') String title,
    @Part(name: 'description') String? description,
    @Part(name: 'loginAccount') String loginAccount,
    @Part(name: 'password') String password,
    @Part(name: 'rank') String? rank,
    @Part(name: 'categoryId') int categoryId,
    @Part(name: 'signInMethodId') int signInMethodId,
    @Part(name: 'price') int price,
    @Part(name: 'attributes') List<CategoryAttributeModel> attributes,
    @Part(name: 'images') List<MultipartFile> images,
    @CancelRequest() CancelToken? cancelToken,
  );
}
