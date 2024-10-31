import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../../common/dialogs/app_dialogs.dart';
import '../../../../../../common/utils/getit_utils.dart';
import '../../../../../../modules/app/app_router.dart';
import '../../../../../../modules/auth/application/cubit/auth_cubit.dart';
import '../../../../../../modules/auth/domain/interfaces/auth_repository_interface.dart';
import '../../../../../../modules/auth/presentation/pages/login_page/login_page.dart';
import '../../../local/storage.dart';
import '../base/api_error.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  bool isRefreshing = false;
  bool isShowingExpireTokenDialog = false;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      final error = response.data['error'];
      if (error != null) {
        throw ApiError.server(
          code: error['code'],
          message: error['message'],
        );
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('auth/refresh-token')) {
      final requestOptions = err.requestOptions;
      if (!isRefreshing) {
        isRefreshing = true;
        final response = await getIt<IAuthRepository>().renewAccessToken();
        response.fold((res) async {
          await Storage.setAccessToken(res.accessToken);
          await Storage.setRefreshToken(res.refreshToken);
          try {
            final newResponse = await getIt<Dio>().fetch(requestOptions);
            handler.resolve(newResponse);
          } catch (e) {
            handler.reject(DioException(
              requestOptions: requestOptions,
              error: e,
            ));
          } finally {
            isRefreshing = false;
          }
        }, (error) {
          isRefreshing = false;
          getIt<AuthCubit>().logout();

          if (!isShowingExpireTokenDialog) {
            isShowingExpireTokenDialog = true;
            getIt<AppRouter>().popUntilRoot();
            AppDialogs.show(
              content: 'Phiên hết hạn',
              action1: () {
                Asuka.showModalBottomSheet(
                  builder: (BuildContext context) {
                    return const AuthPage();
                  },
                  isDismissible: true,
                  elevation: 10,
                  isScrollControlled: true,
                );
              },
            ).whenComplete(() {
              isShowingExpireTokenDialog = false;
            });
          }
        });
      } else {
        try {
          final newResponse = await getIt<Dio>().fetch(requestOptions);
          handler.resolve(newResponse);
        } catch (e) {
          handler
              .reject(DioException(requestOptions: requestOptions, error: e));
        }
      }
    } else {
      handler.next(err);
    }
  }
}
