part of 'sign_in_method_cubit.dart';

@freezed
class SignInMethodState with _$SignInMethodState {
  const factory SignInMethodState.initial(bool isLoading, List<CategorySigninMethodModel> signInMethods, int? selectedId) = _Initial;
}
