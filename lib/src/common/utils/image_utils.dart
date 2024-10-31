import 'dart:io';

import '../constants/app_constants.dart';

bool isHeicFormat(String filePath) {
  return filePath.toLowerCase().endsWith('.heif') ||
      filePath.toLowerCase().endsWith('.heic');
}

bool checkFileSize(File file) {
  int fileSizeInBytes = file.lengthSync();
  double fileSizeInMB = fileSizeInBytes / 1024 / 1024;
  if (fileSizeInMB <= AppConstants.maxImageSize) {
    return true;
  }
  return false;
}

bool isAvifFormat(String url) {
  return url.toLowerCase().endsWith('.avif');
}
