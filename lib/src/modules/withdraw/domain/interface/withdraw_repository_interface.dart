import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../infrastructure/models/bank_account_model.dart';
import '../request_models/withdraw_request.dart';

abstract class IWithdrawRepository {
  Future<int> getAvailableBalance();
  Future setAvailableBalance(int newAvailableBalance);
  Future<Result<List<BankAccountModel>, ApiError>> walletBanks ({CancelToken? token});
  Future<Result<StatusApiResponse, ApiError>> delete (int id,{CancelToken? token});
  Future<Result<StatusApiResponse, ApiError>> createWallet (BankAccountModel request,{CancelToken? token});
  Future<Result<StatusApiResponse, ApiError>> withdraw (WithdrawRequest request,{CancelToken? token});

}
