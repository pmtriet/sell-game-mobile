import 'dart:io';

abstract class EditProfile {
  String? get fullname;
  String? get avatar;
  File? get background;
  String? get bio;
}