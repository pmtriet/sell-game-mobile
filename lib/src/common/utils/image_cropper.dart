import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../generated/colors.gen.dart';
import '../../../generated/l10n.dart';

Future<CroppedFile?> cropImage(
    XFile pickedFile, CropAspectRatioPreset aspectRatio) async {
  try {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: S.current.crop_image,
          toolbarColor: ColorName.background,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          hideBottomControls: true,
          initAspectRatio: aspectRatio,
          aspectRatioPresets: [
            aspectRatio,
          ],
        ),
        IOSUiSettings(
          title: S.current.crop_image,
          aspectRatioPresets: [
            aspectRatio,
          ],
        ),
      ],
    );
    return croppedFile;
  } catch (e) {
    rethrow;
  }
}
