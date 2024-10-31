import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../generated/l10n.dart';
import '../../../common/mixin/cancelable_base_bloc.dart';
import '../../../common/utils/getit_utils.dart';
import '../../../core/infrastructure/datasources/remote/api/base/api_meta_response.dart';
import '../../auth/application/cubit/auth_cubit.dart';
import '../domain/interface/saved_post_repository_interface.dart';
import '../infrastructure/model/saved_post_model.dart';

part 'saved_post_state.dart';
part 'saved_post_cubit.freezed.dart';

class SavedPostCubit extends Cubit<SavedPostState>
    with CancelableBaseBloc<SavedPostState> {
  SavedPostCubit(this._repository)
      : super(const SavedPostState.initial(true, [], null)) {
    fetchSavedPostData();
  }

  final ISavedPostRepository _repository;

  late MetaApiResponse meta;
  late List<SavedPostModel> savedPosts = [];

  Future<void> fetchSavedPostData() async {
    final result = await _repository.getSavedPosts();

    final response = result.fold((success) => success, (failure) => null);
    if (response != null) {
      savedPosts = List.of(response.data);
      meta = response.meta;
    }
    emit(_Initial(false, savedPosts, null));
  }

  Future<void> refresh() async {
    fetchSavedPostData();
  }

  Future<void> loadmore() async {
    if (meta.page < meta.totalPages) {
      final result = await _repository.getSavedPosts(
        page: meta.page + 1,
      );

      final response = result.fold((success) => success, (failure) => null);

      if (response != null) {
        savedPosts.addAll(List.of(response.data));

        meta = response.meta;

        emit(_Initial(false, savedPosts, null));
      }
    }
  }

  void emitToLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void emitToUnloading() {
    emit(state.copyWith(isLoading: false));
  }

  Future<void> deleteSavedPost(int id) async {
    emit(_Initial(true, savedPosts, null));
    final result = await getIt<AuthCubit>().deleteFavouriteProduct(id);

    if (result) {
      fetchSavedPostData();
    } else {
      emit(state.copyWith(
          isLoading: false, errorMessage: S.current.error_unexpected));
    }
  }
}
