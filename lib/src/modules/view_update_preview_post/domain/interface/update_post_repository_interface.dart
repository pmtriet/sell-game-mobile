import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';

abstract class IUpdatePostRepository {
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
      CancelToken? token});
}
