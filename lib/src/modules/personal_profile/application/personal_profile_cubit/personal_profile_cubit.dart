import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../shop_profile/infrastructure/models/shop_account_model.dart';
import '../../domain/interface/personal_profile_repository_interface.dart';

part 'personal_profile_state.dart';
part 'personal_profile_cubit.freezed.dart';

class PersonalProfileCubit extends Cubit<PersonalProfileState>
    with CancelableBaseBloc<PersonalProfileState> {
  final IPersonalProfileRepository _repository;
  PersonalProfileCubit(this._repository)
      : super(const PersonalProfileState.initial(true, null, null)) {
    getShopProfile();
  }

  Future<void> getShopProfile() async {
    final user = Storage.user;
    if (user != null) {
      int userId = user.id;

      final result = await _repository.getProfileShop(userId);

      result.fold((success) {
        emit(_Initial(false, success, null));
      }, (failure) {
        emit(const _Initial(false, null, true));
      });
    } else {
      emit(const _Initial(false, null, true));
    }
  }
}
