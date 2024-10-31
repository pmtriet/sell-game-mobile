import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../domain/interface/notification_repository_interface.dart';
import '../../infrastructure/models/notification_model.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

@singleton
class NotificationCubit extends Cubit<NotificationState>
    with CancelableBaseBloc<NotificationState> {
  final INotificationRepository _repository;

  NotificationCubit(this._repository)
      : super(const NotificationState.initial(true, null));
  late MetaApiResponse meta;
  late List<NotificationModel> notifications = [];

  Future<void> fetchNotificationData() async {
    final result = await _repository.notification();

    final response = result.fold((success) => success, (failure) => null);
    if (response != null) {
      notifications = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(false, notifications));
  }

  Future<void> refresh() async {
    fetchNotificationData();
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.notification(
        page: meta.page + 1,
      );

      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        notifications.addAll(List.of(response.data));

        meta = response.meta;

        if (!isClosed) {
          emit(_Initial(false, notifications));
        }
      }
    }
  }
}
