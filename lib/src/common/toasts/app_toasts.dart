import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

class AppToasts {
  static Future<void> show(String title) async {
    Asuka.showSnackBar(SnackBar(content: Text(title)));
  }
}
