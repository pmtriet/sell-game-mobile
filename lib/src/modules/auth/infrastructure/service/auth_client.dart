import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../domain/request_models/login_request_models/login_request.dart';
import '../models/auth_token.dart';
import '../models/user_model.dart';

part 'auth_client.g.dart';

@RestApi()
@injectable
abstract class AuthClient {
  @factoryMethod
  factory AuthClient(Dio dio) = _AuthClient;

  @POST('/v1/auth/login')
  Future<SingleApiResponse<UserModel>> login(
    @Body() LoginRequest request,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/user')
  Future<ListApiResponse<UserModel>> users(
      @CancelRequest() CancelToken? cancelToken);

  @GET('/user/{id}')
  Future<SingleApiResponse<UserModel>> user(
    @Path('id') String id,
    @CancelRequest() CancelToken? cancelToken,
  );

  @POST('/v1/auth/refresh-token')
  Future<SingleApiResponse<AuthToken>> refreshToken(
    @Body() Map<String, String> refreshToken,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/auth/get-profile')
  Future<SingleApiResponse<UserModel>> getProfile(
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/v1/bookmarks/list')
  Future<SingleApiResponse<List<int>>> getFavouriteProducts(
    @CancelRequest() CancelToken? cancelToken,
  );

  @POST('/v1//bookmarks/{productId}')
  Future<StatusApiResponse> setFavouriteProduct(
    @Path('productId') int productId,
    @CancelRequest() CancelToken? cancelToken,
  );

  @DELETE('/v1//bookmarks/{productId}')
  Future<StatusApiResponse> deleteFavouriteProduct(
    @Path('productId') int productId,
    @CancelRequest() CancelToken? cancelToken,
  );
}
