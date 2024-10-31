part of '../page/report_page.dart';

class AddImagesWidget extends StatefulWidget {
  const AddImagesWidget({
    super.key,
    required this.images,
    required this.onSelectImage,
    required this.onDeleteImage,
    required this.setStateLoading,
  });
  final List<File> images;
  final Function(File file) onSelectImage;
  final Function(File file) onDeleteImage;
  final Function(bool isLoading) setStateLoading;

  @override
  State<AddImagesWidget> createState() => _AddImagesWidgetState();
}

class _AddImagesWidgetState extends State<AddImagesWidget> {
  bool isPicking = false;

  final ImagePicker _picker = ImagePicker();

  void selectImage(File file) {
    //add images to cubit
    widget.onSelectImage(file);
  }

  void showErrorImage(String message) {
    AppDialogs.show(type: AlertType.error, content: message);
  }

  Future<void> onPickImage() async {
    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    // File? selectedImgFile;

    // if (pickedFile != null) {
    //   selectedImgFile = File(pickedFile.path);

    //   if (checkFileSize(selectedImgFile)) {
    //     selectImage(selectedImgFile);
    //   } else {
    //     showErrorImage();
    //   }
    // }

    // if (pickedFile.length > AppConstants.maxImagePost) {
    //   AppDialogs.show(
    //       type: AlertType.error, content: S.current.error_post_image_length);
    //   return;
    // }

    if (isPicking) {
      return;
    }

    isPicking = true;
    widget.setStateLoading(true);

    try {
      final List<XFile> pickedFile =
          await _picker.pickMultiImage(limit: AppConstants.maxImagePost);

      if (pickedFile.isNotEmpty) {
        File? selectedImgFile;
        for (var file in pickedFile) {
          selectedImgFile = File(file.path);

          if (isHeicFormat(selectedImgFile.path)) {
            String? pngPath = await HeifConverter.convert(selectedImgFile.path,
                format: 'png');
            if (pngPath != null) {
              selectedImgFile = File(pngPath);
              selectImage(selectedImgFile);
            } else {
              showErrorImage(S.current.error_file_image_heic);
            }
          } else {
            if (checkFileSize(selectedImgFile)) {
              selectImage(selectedImgFile);
            } else {
              showErrorImage(S.current.error_file_image_size);
            }
          }
        }
      }
    } catch (e) {
      AppDialogs.show(
          type: AlertType.error, content: S.current.error_unexpected);
    }

    isPicking = false;
    widget.setStateLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.images.isEmpty)
              //add images widget when no images selected
              ? AddImageMiniWidget(
                  onSelect: () {
                    //pick images
                    onPickImage();
                  },
                )
              : //list image
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.w,
                      ),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          widget.images.length < AppConstants.maxImagePost
                              ? widget.images.length + 1
                              : widget.images.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return widget.images.length <
                                  AppConstants.maxImagePost
                              ? AddImageMiniWidget(onSelect: () {
                                  onPickImage();
                                })
                              : ImageWidget(
                                  image: widget.images[index],
                                  onDeleteNewImage: () {
                                    //delete image
                                    widget.onDeleteImage(widget.images[index]);
                                  },
                                );
                        } else {
                          dynamic image;
                          widget.images.length < AppConstants.maxImagePost
                              ? image = widget.images[index - 1]
                              : image = widget.images[index];
                          return ImageWidget(
                            image: image,
                            onDeleteNewImage: () {
                              //delete image
                              widget.onDeleteImage(image);
                            },
                          );
                        }
                      }),
                )
        ],
      ),
    );
  }
}
