
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../home/infrastructure/models/category_models/category_attribute_model.dart';
import '../../domain/interface/post_repository_interface.dart';
import '../service/post_api.dart';

@Injectable(as: IPostRepository)
class PostRepository implements IPostRepository {
  final PostApi _api;

  PostRepository(this._api);

  @override
  Future<Result<StatusApiResponse, ApiError>> post(
      String title,
      String? description,
      String loginAccount,
      String password,
      String? rank,
      int categoryId,
      int signInMethodId,
      int price,
      List<CategoryAttributeModel> attributes,
      List<MultipartFile> images,
      {CancelToken? token}) async {
    return await _api
        .post(title, description, loginAccount, password, rank, categoryId,
            signInMethodId, price, attributes, images, token)
        .tryGet((response) => response);
  }
}
