import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/validator.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../auth/infrastructure/models/user_model.dart';
import '../../../personal_profile_edit/domain/interfaces/profile_repository_interface.dart';

part 'name_edition_state.dart';
part 'name_edition_cubit.freezed.dart';

@Injectable()
class NameEditionCubit extends Cubit<NameEditionState>
    with CancelableBaseBloc<NameEditionState> {
  final IProfileRepository _repository;

  NameEditionCubit(this._repository) : super(const NameEditionState.initial());

  UserModel? getUser() {
    final result = _repository.getUser();
    if (result is UserModel) {
      return result;
    }
    return null;
  }

  Future<void> validate(String name) async {
    emit(const _Loading());
    if (Validator.isEmptyUserName(name)) {
      emit(_Error(S.current.error_empty_username));
    } else if (!Validator.isValidFullName(name)) {
      emit(_Error(S.current.error_invalid_username));
    } else {
      final result = await _repository.update(name, null, null, null);
      result.fold((success) {
        //get storage user
        var currentUser = getUser();
        if (currentUser != null) {
          //storage new user
          final newUser = currentUser.copyWith(fullname: name);
          _repository.setUser(newUser);

          //set new User for Authenticated State of whole app
          getIt<AuthCubit>().emitNewUser(newUser);

          emit(const _Success());
        } else {
          getIt<AuthCubit>().logout();
        }
      },
          // Handle error: api update error
          (failure) => emit(_Error(S.current.error_unexpected)));
    }
  }
}
