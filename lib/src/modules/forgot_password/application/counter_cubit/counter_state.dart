part of 'counter_cubit.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.initial() = _Initial;
  const factory CounterState.count(int count) = _Count;
}
