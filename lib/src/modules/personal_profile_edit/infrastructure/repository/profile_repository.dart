
import 'package:injectable/injectable.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/infrastructure/models/user_model.dart';
import '../../domain/interfaces/profile_repository_interface.dart';
import '../service/profile_api.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';

@Injectable(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final ProfileApi _api;

  ProfileRepository(this._api);

  @override
  Future<String?> getAccessToken() async => await Storage.accessToken;

  @override
  UserModel? getUser() => Storage.user;

  @override
  Future setUser(User? val) async {
    if (val is UserModel?) {
      return Storage.setUser(val);
    }
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> update(
      String? fullname, List<MultipartFile>? avatar, List<MultipartFile>? background, String? bio,
      {CancelToken? token}) async {
    if (avatar != null && background != null) {
      return await _api
          .update(fullname, avatar, background, bio, token)
          .tryGet((response) => response);
    }

    if (avatar == null && background != null) {
      return await _api
          .updateNoAvatar(fullname, background, bio, token)
          .tryGet((response) => response);
    }
    if (background == null && avatar != null) {
      // final multipartFiles = <MultipartFile>[];
      // List<File> files = [avatar];

      // // Lấy MIME type từ file avatar
      // String? mimeType =
      //     lookupMimeType(avatar.path) ?? 'application/octet-stream';

      // // Đây là một file ảnh
      // if (mimeType.startsWith('image/')) {
      //   for (final file in files) {
      //     final fileBytes = await file.readAsBytes();
      //     final multipartFile = MultipartFile.fromBytes(
      //       fileBytes,
      //       filename: file.path.split('/').last,
      //       contentType: MediaType('image', '*'),
      //     );
      //     multipartFiles.add(multipartFile);
      //   }
      // }

      return await _api
          .updateNoBackground(fullname, avatar, bio, token)
          .tryGet((response) => response);
    }
    return await _api
        .updateInfor(fullname, bio, token)
        .tryGet((response) => response);
  }

  @override
  Future<Result<UserModel, ApiError>> profile({CancelToken? token}) async {
    return await _api.profile(token).tryGet((response) => response.data);
  }
}
