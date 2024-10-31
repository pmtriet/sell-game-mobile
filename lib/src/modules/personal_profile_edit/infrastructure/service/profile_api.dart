
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../auth/infrastructure/models/user_model.dart';



part 'profile_api.g.dart';

@RestApi()
@injectable
abstract class ProfileApi {
  @factoryMethod
  factory ProfileApi(Dio dio) = _ProfileApi;

  @PUT('/v1/auth/update-profile')
  @MultiPart()
  Future<StatusApiResponse> update(
    @Part(name: 'fullname') String? fullname,
    @Part(name: 'avatar') List<MultipartFile> avatar,
    @Part(name: 'background') List<MultipartFile> background,
    @Part(name: 'bio') String? bio,
    @CancelRequest() CancelToken? cancelToken,
  );

  @PUT('/v1/auth/update-profile')
  @MultiPart()
  Future<StatusApiResponse> updateNoBackground(
    @Part(name: 'fullname') String? fullname,
    @Part(name: 'avatar') List<MultipartFile> avatar,
    @Part(name: 'bio') String? bio,
    @CancelRequest() CancelToken? cancelToken,
  );
  // @PUT('/v1/auth/update-profile')
  // @MultiPart()
  // Future<StatusApiResponse> updateNoBackground(
  //   @Part(name: 'fullname') String? fullname,
  //   @Part(name: 'avatar') MultipartFile avatar,
  //   @Part(name: 'bio') String? bio,
  //   @CancelRequest() CancelToken? cancelToken,
  // );

  @PUT('/v1/auth/update-profile')
  @MultiPart()
  Future<StatusApiResponse> updateNoAvatar(
    @Part(name: 'fullname') String? fullname,
    @Part(name: 'background') List<MultipartFile> background,
    @Part(name: 'bio') String? bio,
    @CancelRequest() CancelToken? cancelToken,
  );

  @PUT('/v1/auth/update-profile')
  @MultiPart()
  Future<StatusApiResponse> updateInfor(
    @Part(name: 'fullname') String? fullname,
    @Part(name: 'bio') String? bio,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/auth/get-profile')
  Future<SingleApiResponse<UserModel>> profile(
      @CancelRequest() CancelToken? cancelToken);
}
