import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/api_client.dart';
import '../../domain/interface/withdraw_repository_interface.dart';
import '../../domain/request_models/withdraw_request.dart';
import '../models/bank_account_model.dart';
import '../service/withdraw_api.dart';

@Injectable(as: IWithdrawRepository)
class WithdrawRepository implements IWithdrawRepository {
  final WithdrawApi _api;

  WithdrawRepository(this._api);

  @override
  Future<int> getAvailableBalance() async {
    return 0;
  }

  @override
  Future setAvailableBalance(int newAvailableBalance) async {}
  @override
  Future<Result<List<BankAccountModel>, ApiError>> walletBanks(
      {CancelToken? token}) async {
    return await _api.walletBanks(token).tryGet((response) => response.data);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> delete(int id,
      {CancelToken? token}) async {
    return await _api.deleteWallet(id, token).tryGet((response) => response);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> createWallet(BankAccountModel request, {CancelToken? token}) async {
    return await _api.createWallet(request, token).tryGet((response) => response);
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> withdraw(WithdrawRequest request, {CancelToken? token}) async {
    return await _api.withdraw(request, token).tryGet((response) => response);
  }
}
