
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';  // Import dartz for Either
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../../auth/infrastructure/models/user_model.dart';
import '../models/voucher_model.dart';
import '../service/buy_api.dart';
import '../repositories/buy_repository_interface.dart';

@LazySingleton(as: IBuyRepository)
class BuyRepository implements IBuyRepository {
  final BuyApi _api;

  BuyRepository(this._api);

  @override
  Future<Either<ApiError, VoucherModel>> findVoucher(String code, int productId, {CancelToken? token}) async {
    try {
      final body = {
        'code': code,
        'productId': productId,
      };

      // Thực hiện POST request đến API voucher/find và ánh xạ kết quả sang VoucherModel
      final response = await _api.findVoucher(body, token);
      final voucherData = response.data;  
      return Right(voucherData);
    } catch (error) {
      if (error is DioException) {
        return Left(ApiError.network(code: error.response?.statusCode, message: error.response!.data['message']));
      } else {
        return Left( ApiError.unexpected());
      }
    }
  }

  @override
  Future<Either<ApiError, void>> purchase(int productId, String? voucherCode, {CancelToken? token}) async {
    try {
      final body = {
        'productId': productId,
        if (voucherCode != null) 'voucherCode': voucherCode,
      };

      await _api.purchase(body, token);
      return const Right(null);  // Success
    } catch (error) {
      return Left(_mapErrorToApiError(error));  // Handle error
    }
  }

  // Mapping DioException to ApiError
  ApiError _mapErrorToApiError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final statusCode = error.response?.statusCode;
        final message = error.response?.statusMessage ?? 'Lỗi không xác định từ server';

        // Handle based on HTTP status codes
        switch (statusCode) {
          case 401:
            return ApiError.unauthorized(message);
          case 500:
            return ApiError.server(code: statusCode, message: 'Lỗi máy chủ nội bộ');
          default:
            return ApiError.network(code: statusCode, message: error.response!.data['message']);
        }
      } else {
        // Handle network errors and others
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            return ApiError.network(code: error.response?.statusCode, message: 'Connection timed out');
          case DioExceptionType.cancel:
            return ApiError.cancelled();
          case DioExceptionType.connectionError:
            return ApiError.network(code: error.response?.statusCode, message: 'Lỗi kết nối mạng');
          default:
            return ApiError.internal('Internal error: ${error.message}');
        }
      }
    }

    // Return unexpected error for other cases
    return ApiError.unexpected();
  }

  @override
  Future<Result<UserModel, ApiError>> profile({CancelToken? token}) async {
    return await _api.profile(token).tryGet((response) => response.data);
  }
}
