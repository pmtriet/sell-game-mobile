part of 'personal_profile_cubit.dart';

@freezed
class PersonalProfileState with _$PersonalProfileState {
  const factory PersonalProfileState.initial(bool isLoading, ShopAccountModel? shopInfor, bool? isError) = _Initial;
}
