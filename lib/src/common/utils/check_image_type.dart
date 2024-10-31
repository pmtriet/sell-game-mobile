 import 'dart:io';

import 'package:mime/mime.dart';

bool checkImageType(File file) {
    String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';

    //file image
    if (mimeType.startsWith('image/')) {
      return true;
    } else {
      return false;
    }
  }