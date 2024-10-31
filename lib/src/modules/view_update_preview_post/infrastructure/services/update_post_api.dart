import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';

part 'update_post_api.g.dart';

@RestApi()
@injectable
abstract class UpdatePostApi {
  @factoryMethod
  factory UpdatePostApi(Dio dio) = _UpdatePostApi;

  @PUT('/v1/products/{id}')
  @MultiPart()
  Future<StatusApiResponse> updatePost(
    @Path('id') int id,
    @Part(name: 'title') String? title,
    @Part(name: 'description') String? description,
    @Part(name: 'loginAccount') String? loginAccount,
    @Part(name: 'password') String? password,
    @Part(name: 'rank') String? rank,
    @Part(name: 'price') int? price,
    @Part(name: 'attributes') List<CategoryAttributeModel>? attributes,
    @Part(name: 'signInMethodId') int? signInMethodId,
    @Part(name: 'images') List<MultipartFile>? images,
    @Part(name: 'imagesToDelete') String? imagesToDelete,
    @CancelRequest() CancelToken? cancelToken,
  );
}
