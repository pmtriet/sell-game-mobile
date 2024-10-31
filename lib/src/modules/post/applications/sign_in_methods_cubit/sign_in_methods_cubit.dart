import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';

part 'sign_in_methods_state.dart';
part 'sign_in_methods_cubit.freezed.dart';

class SignInMethodsCubit extends Cubit<SignInMethodsState> with CancelableBaseBloc<SignInMethodsState>{
  SignInMethodsCubit() : super(const SignInMethodsState.initial(false, null));

  List<CategorySigninMethodModel> signInMethods = [];

  CategorySigninMethodModel? selected;

  void init(List<CategorySigninMethodModel> newList) {
    emit(_Initial(true, signInMethods));

    signInMethods = newList;

    emit(_Initial(false, signInMethods));
  }

  void onSelect(CategorySigninMethodModel value){
    selected = value;
  }

  CategorySigninMethodModel? getSignInMethod(){
    return selected;
  }
}
