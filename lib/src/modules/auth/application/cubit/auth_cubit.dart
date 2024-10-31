import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/favourite_products.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/validator.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../home/application/cubit/home_cubit.dart';
import '../../../marketplace/application/cubit/marketplace_cubit.dart';
import '../../../notification/application/cubit/notification_cubit.dart';
import '../../domain/entities/user.dart';
import '../../domain/interfaces/auth_repository_interface.dart';
import '../../domain/request_models/login_request_models/login_request.dart';
import '../../infrastructure/models/user_model.dart';
import '../error/auth_error.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> with CancelableBaseBloc<AuthState> {
  final IAuthRepository _repository;

  AuthCubit(this._repository) : super(const _Loading()) {
    _init();
  }
  Future<void> _init() async {
    final user = _repository.getUser();
    if (user != null) {
      emit(_Authenticated(user));
    } else {
      emit(const _Unauthenticated());
    }
  }

  Future<void> login(LoginRequest request) async {
    if (Validator.isEmptyEmail(request.email)) {
      emit(const _Error(AuthError.emptyEmail()));
    } else if (!Validator.isValidEmail(request.email)) {
      emit(const _Error(AuthError.invalidEmail()));
    } else if (!Validator.isValidPasswordLength(request.password)) {
      emit(const _Error(AuthError.invalidPasswordLength()));
    } else if (!Validator.isValidPassword(request.password)) {
      emit(const _Error(AuthError.invalidPassword()));
    } else {
      emit(const _Loading());

      final result = await _repository.login(request);

      emit(result.fold(
        (success) {
          _repository.setUser(success);
          _repository.setAccessToken(success.accessToken);

          //get and save list favourite products
          getFavouriteProducts();

          //getNotification
          getIt<NotificationCubit>().fetchNotificationData();

          return _Authenticated(success);
        },
        (failure) => _Error(
          AuthError.other(failure.message),
        ),
      ));
    }
  }

  void logout() async {
    await state.whenOrNull(authenticated: (_) async {
      emit(const _Loading());
      await _repository.logout();
      emit(const _Unauthenticated());
    });
  }

  void emitNewUser(UserModel user) {
    emit(_Authenticated(user));
  }

  void emitToUnauthenticatedState() {
    if (state is _Error) {
      emit(const _Unauthenticated());
    }
  }

  Future<void> getProfile() async {
    var storageUser = Storage.user;
    //refresh profile
    if (storageUser != null) {
      emit(const _Loading());

      final user = await _repository.getProfile();
      user.fold((success) {
        emit(_Authenticated(success.copyWith()));
        _repository.setUser(success);
        //get list saved posts
        getFavouriteProducts();
      }, (error) => logout());
    }
  }

  Future<void> getFavouriteProducts() async {
    final result = await _repository.getFavouriteProducts();

    final favouriteProducts = result.fold(
      (success) => success,
      (failure) => null,
    );
    if (favouriteProducts != null) {
      var user = Storage.user;
      if (user != null) {
        var newUser = user.copyWith(favouriteProducts: favouriteProducts);
        Storage.setUser(newUser);
      }
    }
  }

  Future<bool> setFavouriteProduct(int productId) async {
    final result = await _repository.setFavouriteProduct(productId);

    return result.fold((success) {
      //save to favourite products
      return FavouriteProductsUntil.addToFavourite(productId);
    }, (failure) => false);
  }

  Future<bool> deleteFavouriteProduct(int productId) async {
    final result = await _repository.deleteFavouriteProduct(productId);

    return result.fold((success) {
      //refresh products in homepage
      getIt<HomeCubit>().refreshListSuggestingProducts();

      //refresh products in marketplace
      getIt<MarketplaceCubit>().fetchData();

      //save to favourite products
      return FavouriteProductsUntil.removeFromFavourite(productId);
    }, (failure) => false);
  }
}
