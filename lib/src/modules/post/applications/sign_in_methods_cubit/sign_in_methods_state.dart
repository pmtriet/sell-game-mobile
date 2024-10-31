part of 'sign_in_methods_cubit.dart';

@freezed
class SignInMethodsState with _$SignInMethodsState {
  const factory SignInMethodsState.initial(bool isLoading, List<CategorySigninMethodModel>? signInMethods) = _Initial;
}
