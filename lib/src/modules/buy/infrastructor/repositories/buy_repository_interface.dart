import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../auth/infrastructure/models/user_model.dart';
import '../models/voucher_model.dart';

abstract class IBuyRepository {
    Future<Either<ApiError, void>> purchase(int productId, String? voucherCode, {CancelToken? token});
    Future<Either<ApiError, VoucherModel>> findVoucher(String code, int productId, {CancelToken? token});
    Future<Result<UserModel, ApiError>> profile({
    CancelToken? token,
  });
}

