import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/validator.dart';

part 'phone_edition_state.dart';
part 'phone_edition_cubit.freezed.dart';

class PhoneEditionCubit extends Cubit<PhoneEditionState> with CancelableBaseBloc<PhoneEditionState>{
  PhoneEditionCubit() : super(const PhoneEditionState.initial());

  bool validate(String phone) {
    emit(const _Initial());
    if(Validator.isEmptyPhone(phone)){
      emit(_Error(S.current.error_empty_phone));
      return false;
    } else if(!Validator.isValidPhone(phone)){
      emit(_Error(S.current.error_invalid_phone));
      return false;
    } else{
      emit(const _Valid());
      return true;
    }
  }
}
