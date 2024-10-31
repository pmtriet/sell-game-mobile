part of '../pages/personalprofile_edit_page.dart';

class PersonalProfileEditImgWidget extends StatefulWidget {
  const PersonalProfileEditImgWidget({super.key, required this.user});
  final User user;

  @override
  State<PersonalProfileEditImgWidget> createState() =>
      _PersonalProfileEditImgWidgetState();
}

class _PersonalProfileEditImgWidgetState
    extends State<PersonalProfileEditImgWidget> {
  File? _selectedAvatarImg;
  File? _selectedBackgroundImg;

  final ImagePicker _picker = ImagePicker();

  bool isSelected = false;

  Future<void> _pickAvatarImg() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        isSelected = true;
        //crop image
        CroppedFile? cropFile =
            await cropImage(pickedFile, CropAspectRatioPreset.square);

        if (cropFile != null) {
          setState(() {
            _selectedAvatarImg = File(cropFile.path);
            if (_selectedAvatarImg != null) {
              context
                  .read<PersonalprofileEditCubit>()
                  .editAvatar(_selectedAvatarImg!);
            }
          });
        }
      }
    } catch (e) {
      AppDialogs.show(
          type: AlertType.error, content: S.current.error_unexpected);
    }
  }

  Future<void> _pickBackgroundImg() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        isSelected = true;

        //crop image
        CroppedFile? cropFile =
            await cropImage(pickedFile, CropAspectRatioPreset.ratio16x9);

        if (cropFile != null) {
          setState(() {
            _selectedBackgroundImg = File(cropFile.path);
            if (_selectedBackgroundImg != null) {
              context
                  .read<PersonalprofileEditCubit>()
                  .editBackground(_selectedBackgroundImg!);
            }
          });
        }
      }
    } catch (e) {
      AppDialogs.show(
          type: AlertType.error, content: S.current.error_unexpected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalprofileEditCubit, PersonalprofileEditState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () => isSelected = true,
          editting: () => isSelected = true,
          orElse: () => isSelected = false,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.w),
        child: SizedBox(
          height: 160.w,
          width: 390.w,
          child: Stack(
            children: [
              //cover img and background of infor widget
              Column(
                children: [
                  //cover img
                  Stack(
                    children: [
                      SizedBox(
                        height: 120.w,
                        width: 390.w,
                        child: _selectedBackgroundImg != null && isSelected
                            ? Image.file(
                                _selectedBackgroundImg!,
                                fit: BoxFit.cover,
                              )
                            : widget.user.background.filePath.isNotEmpty
                                ? CacheImageWidget(
                                    url: widget.user.background.filePath,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: ColorName.grey353535,
                                  ),
                      ),
                      //camera icon button of cover
                      Positioned(
                        right: 16.w,
                        bottom: 16.w,
                        child: GestureDetector(
                          onTap: _pickBackgroundImg,
                          child: Container(
                            width: 29.w,
                            height: 29.w,
                            decoration: const BoxDecoration(
                              color: ColorName.black1E1E1E,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: ColorName.whiteF1F1F1,
                                size: 18.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 36,
                    color: ColorName.background,
                  )
                ],
              ),
              //avatar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        //avatar
                        Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: _selectedAvatarImg != null && isSelected
                                ? Image.file(
                                    _selectedAvatarImg!,
                                    fit: BoxFit.cover,
                                  )
                                : widget.user.avatar.filePath.isNotEmpty
                                    ? CacheImageWidget(
                                        url: widget.user.avatar.filePath,
                                        fit: BoxFit.cover,
                                      )
                                    : Assets.images.defaultUserAvatar.image(),
                          ),
                        ),
                        //camera icon button of avatar
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: _pickAvatarImg,
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              decoration: const BoxDecoration(
                                color: ColorName.black,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 26.w,
                                  height: 26.w,
                                  decoration: const BoxDecoration(
                                    color: ColorName.grey353535,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: ColorName.whiteF1F1F1,
                                      size: 14.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
