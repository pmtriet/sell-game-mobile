import 'package:flutter/material.dart';

abstract class TextThemeFactory {
  TextTheme create();

  TextStyle get light;
  TextStyle get regular;
  TextStyle get medium;
  TextStyle get semiBold;
  TextStyle get bold;

  TextStyle get displayMedium;
  TextStyle get displayLarge;
  TextStyle get displaySmall;

  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;

  TextStyle get contentSmall;
  TextStyle get contentLarge;
  TextStyle get productTitle;
  TextStyle get discount;
  TextStyle get originalPrice;
  TextStyle get titleSmall;

  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get bodySmall;

  TextStyle get bodyMedium;
  TextStyle get bodyLarge;
  TextStyle get captionMedium;

  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;

  TextStyle get contentMedium;
  

  TextStyle get captionSmall;
  TextStyle get caption;
  TextStyle get captionLarge;

  TextStyle get headingSmall;
}
