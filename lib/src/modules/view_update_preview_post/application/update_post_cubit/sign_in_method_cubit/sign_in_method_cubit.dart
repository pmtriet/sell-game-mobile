import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../home/infrastructure/models/category_models/category_signinmethod_model.dart';

part 'sign_in_method_state.dart';
part 'sign_in_method_cubit.freezed.dart';

class SignInMethodCubit extends Cubit<SignInMethodState> with CancelableBaseBloc<SignInMethodState>{
  int? selectedId;
  SignInMethodCubit(this.selectedId) : super(const SignInMethodState.initial(false, [], null));
  
  List<CategorySigninMethodModel> signInMethods = [];

  CategorySigninMethodModel? current;
  bool isInitial = true;

  void init(List<CategorySigninMethodModel> newList) {
    emit(state.copyWith(isLoading: true));
 
    signInMethods = newList;

    if(isInitial){
      isInitial = !isInitial;
      for(var signInMethod in signInMethods){
        if(signInMethod.id == selectedId){
          current = signInMethod;
          break;
        }
      }
    } else{
      selectedId = null;
    }

    emit(_Initial(false, signInMethods, selectedId));
  }

  void onSelect(CategorySigninMethodModel value){
    current = value;
  }

  CategorySigninMethodModel? getSignInMethod(){
    return current;
  }
}
