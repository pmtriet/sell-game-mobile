part of '../../page/update_post_page.dart';

class AddImagesWidget extends StatefulWidget {
  const AddImagesWidget({
    super.key,
    required this.newImages,
    required this.onSelectNewImage,
    required this.selectedRemainingImages,
    required this.onDeleteSelectedRemainingImage,
    required this.onDeleteNewImage,
    required this.onLoading,
    required this.unLoading,
  });
  final List<ProductImageModel> selectedRemainingImages;
  final List<File> newImages;
  final Function(File image) onSelectNewImage;
  final Function(ProductImageModel filePath) onDeleteSelectedRemainingImage;
  final Function(File image) onDeleteNewImage;
  final VoidCallback onLoading;
  final VoidCallback unLoading;

  @override
  State<AddImagesWidget> createState() => _AddImagesWidgetState();
}

class _AddImagesWidgetState extends State<AddImagesWidget> {
  bool isPicking = false;

  final ImagePicker _picker = ImagePicker();

  void selectImage(File file) {
    widget.onSelectNewImage(file);
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

    if (isPicking) {
      return;
    }

    isPicking = true;
    widget.onLoading();

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
    widget.unLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.s.images_and_videos_game,
            style: context.textTheme.titleSmall
                .copyWith(color: ColorName.whiteF1F1F1),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: context.s.content_posting_must_obey,
                  style: context.textTheme.bodyMedium.copyWith(fontSize: 18),
                ),
                TextSpan(
                  text: context.s.post_rule,
                  style: context.textTheme.bodyMedium
                      .copyWith(color: ColorName.primary, fontSize: 18),
                ),
              ],
            ),
          ),
          //list images
          (widget.newImages.isEmpty && widget.selectedRemainingImages.isEmpty)
              //display add_images_widget when no images
              ? GestureDetector(
                  onTap: () {
                    onPickImage();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(UIConstants.itemRadius),
                      shape: BoxShape.rectangle,
                    ),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(UIConstants.itemRadius),
                      dashPattern: const [6, 6],
                      color: Colors.greenAccent,
                      strokeWidth: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icons.camera.svg(),
                              const SizedBox(height: 8),
                              Text(
                                context.s.add_images,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      itemCount: 1 +
                          widget.newImages.length +
                          widget.selectedRemainingImages.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return AddImageMiniWidget(onSelect: () {
                            onPickImage();
                          });
                        } else {
                          if (index <= widget.selectedRemainingImages.length) {
                            //selected images
                            final filePath = widget
                                .selectedRemainingImages[index - 1].filePath;
                            return ImageFromFilePathWidget(
                              imageFilePath: filePath,
                              onDeleteSelectedRemainingImage: () =>
                                  widget.onDeleteSelectedRemainingImage(widget
                                      .selectedRemainingImages[index - 1]),
                              isFirst: index == 1 ? true : null,
                            );
                          } else {
                            //new images
                            final image = widget.newImages[index -
                                1 -
                                widget.selectedRemainingImages.length];
                            return ImageWidget(
                              image: image,
                              onDeleteNewImage: () =>
                                  widget.onDeleteNewImage(image),
                              isFirst: index == 1 ? true : null,
                            );
                          }
                        }
                      }),
                )
        ],
      ),
    );
  }
}
