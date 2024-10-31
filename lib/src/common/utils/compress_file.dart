 import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

import '../constants/app_constants.dart';

Future<File> compressFile(File file) async {
    bool loop = true;
    File compressedFile = file;
    while (loop) {
      if (file.lengthSync() / 1024 / 1024 >
          AppConstants.maxImageSizeCompressed) {
        compressedFile = await FlutterNativeImage.compressImage(
          file.path,
          quality: 70,
        );
        file = compressedFile;
      } else {
        loop = false;
      }
    }
    return compressedFile;
  }