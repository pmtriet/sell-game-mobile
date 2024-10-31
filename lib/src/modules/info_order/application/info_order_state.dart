import 'package:freezed_annotation/freezed_annotation.dart';
import '../infrastructure/models/info_order_model.dart';

part 'info_order_state.freezed.dart';

@freezed
class InfoOrderState with _$InfoOrderState {
  const factory InfoOrderState.loading() = _Loading;
  const factory InfoOrderState.loaded(InfoOrderModel orderInfo) = _Loaded;
  const factory InfoOrderState.error(String message) = _Error;
}
