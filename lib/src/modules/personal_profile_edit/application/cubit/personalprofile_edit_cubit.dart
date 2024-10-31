import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/check_image_type.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/infrastructure/models/user_model.dart';
import '../../domain/interfaces/profile_repository_interface.dart';
import 'package:http_parser/http_parser.dart';
part 'personalprofile_edit_state.dart';
part 'personalprofile_edit_cubit.freezed.dart';

@Injectable()
class PersonalprofileEditCubit extends Cubit<PersonalprofileEditState> with CancelableBaseBloc<PersonalprofileEditState>{
  final IProfileRepository _repository;
  late User user;
  String? name;
  File? avatar;
  File? background;
  String? bio;

  PersonalprofileEditCubit(this._repository)
      : super(const PersonalprofileEditState.initial()) {
    init();
  }
  void init() {
    name = bio = avatar = background = null;

    var currentUser = _repository.getUser();
    if (currentUser != null) {
      user = currentUser;
      emit(_Loaded(user));
    }
  }

  void editName(String name) {
    this.name = name;
    if (state is! _Editting) {
      emit(const _Editting());
    }
  }

  void editAvatar(File avatar) {
    this.avatar = avatar;
    if (state is! _Editting) {
      emit(const _Editting());
    }
  }

  void editBackground(File background) {
    this.background = background;
    if (state is! _Editting) {
      emit(const _Editting());
    }
  }

  void editBio(String bio) {
    this.bio = bio;
    if (state is! _Editting) {
      emit(const _Editting());
    }
  }

  Future<UserModel?> profile() async {
    final result = await _repository.profile();
    return result.fold((success) {
      if (success is UserModel) {
        return success;
      }
      return null;
    }, (failure) => null);
  }

  Future<void> update() async {
    emit(const _Loading());

    //get current token
    final accessToken = await _repository.getAccessToken();

    if (accessToken != null) {
      final avatarMultipartFiles = <MultipartFile>[];
      final backgroundMultipartFiles = <MultipartFile>[];

      //convert avatar input file
      if (avatar != null) {
        //correct image file
        if (checkImageType(avatar!)) {
          final fileBytes = await avatar!.readAsBytes();
          final avatarMultipartFile = MultipartFile.fromBytes(
            fileBytes,
            filename: avatar!.path.split('/').last,
            contentType: MediaType('image', '*'),
          );
          avatarMultipartFiles.add(avatarMultipartFile);
        }
        //error image file
        else {
          emit(_Error(S.current.error_file_image));
        }
      }

      //convert background input file
      if (background != null) {
        //correct image file
        if (checkImageType(background!)) {
          final fileBytes = await background!.readAsBytes();
          final backgroundMultipartFile = MultipartFile.fromBytes(
            fileBytes,
            filename: background!.path.split('/').last,
            contentType: MediaType('image', '*'),
          );
          backgroundMultipartFiles.add(backgroundMultipartFile);
        }
        //error image file
        else {
          emit(_Error(S.current.error_file_image));
        }
      }

      final result = await _repository.update(
          name, avatarMultipartFiles, backgroundMultipartFiles, bio);

      result.fold((success) async {
        //call api to get new profile
        final newProfile = await profile();
        if (newProfile != null) {
          //storage new user
          final newUser = newProfile.copyWith(accessToken: accessToken);
          _repository.setUser(newUser);

          //set new User for Authenticated State of whole app
          getIt<AuthCubit>().emitNewUser(newUser);

          //reset state
          init();
        }
        // Handle error: api get profile error || newProfile is not a UserModel
        else {
          emit(_Error(S.current.error_unexpected));
        }
      },
          // Handle error: api update error
          (failure) => emit(_Error(S.current.error_unexpected)));
    } else {
      getIt<AuthCubit>().logout();
    }
  }

  void logout() {
    emit(const _Loading());
    getIt<AuthCubit>().logout();
  }
}
