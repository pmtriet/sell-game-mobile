part of 'tabbar_cubit.dart';

@freezed
class TabbarState with _$TabbarState {
  const factory TabbarState.initial(bool isLoading, int index) = _Initial;
}
