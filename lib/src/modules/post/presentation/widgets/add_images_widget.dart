part of '../pages/post_page.dart';

class AddImagesWidget extends StatefulWidget {
  const AddImagesWidget({
    super.key,
    this.images,
    required this.onLoading,
    required this.unLoading,
  });
  final List<File>? images;
  final VoidCallback onLoading;
  final VoidCallback unLoading;

  @override
  State<AddImagesWidget> createState() => _AddImagesWidgetState();
}

class _AddImagesWidgetState extends State<AddImagesWidget> {
  bool isPicking = false;

  final ImagePicker _picker = ImagePicker();

  void selectImage(File file) {
    context.read<AddImageCubit>().onSelectImage(file);
  }

  void showErrorImage(String message) {
    AppDialogs.show(type: AlertType.error, content: message);
  }

  Future<void> onPickImage() async {
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
                  style: context.textTheme.bodyMedium.copyWith(),
                ),
                TextSpan(
                  text: context.s.post_rule,
                  style: context.textTheme.bodyMedium
                      .copyWith(color: ColorName.primary),
                ),
              ],
            ),
          ),
          !(widget.images != null && widget.images!.isNotEmpty)
              //add images widget when no images selected
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
                      itemCount:
                          widget.images!.length < AppConstants.maxImagePost
                              ? widget.images!.length + 1
                              : widget.images!.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return widget.images!.length <
                                  AppConstants.maxImagePost
                              ? AddImageMiniWidget(onSelect: () {
                                  onPickImage();
                                })
                              : ImageWidget(
                                  image: widget.images![index],
                                  onDeleteNewImage: () {
                                    context
                                        .read<AddImageCubit>()
                                        .onDeleteImage(widget.images![index]);
                                  },
                                );
                        } else {
                          dynamic image;
                          widget.images!.length < AppConstants.maxImagePost
                              ? image = widget.images![index - 1]
                              : image = widget.images![index];
                          return ImageWidget(
                            image: image,
                            onDeleteNewImage: () {
                              context
                                  .read<AddImageCubit>()
                                  .onDeleteImage(image);
                            },
                            isFirst: index == 1 ? true : null,
                          );
                        }
                      }),
                )
        ],
      ),
    );
  }
}
