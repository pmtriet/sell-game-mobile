import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../domain/interface/update_post_repository_interface.dart';
import '../services/update_post_api.dart';

@LazySingleton(as: IUpdatePostRepository)
class UpdatePostRepository implements IUpdatePostRepository {
  final UpdatePostApi _api;

  UpdatePostRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> updatePost(int productId,
      {String? title,
      String? description,
      String? loginAccount,
      String? password,
      String? rank,
      int? price,
      List<CategoryAttributeModel>? attributes,
      int? signInMethodId,
      List<MultipartFile>? images,
      String? imagesToDelete,
      CancelToken? token}) async {
    return await _api
        .updatePost(productId, title, description, loginAccount, password, rank,
            price, attributes, signInMethodId, images, imagesToDelete, token)
        .tryGet((response) => response);
  }
}
