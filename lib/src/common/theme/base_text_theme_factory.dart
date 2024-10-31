import 'package:flutter/material.dart';

import '../../../generated/colors.gen.dart';
import '../../../generated/fonts.gen.dart';
import 'text_theme_interfaces.dart';

abstract class BaseTextThemeFactory implements TextThemeFactory {
  @override
  TextTheme create() {
    return TextTheme(
      displayLarge: displayMedium,
      displayMedium: displayLarge,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: contentSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: bodySmall,
      bodyLarge: bodyMedium,
      bodyMedium: bodyLarge,
      bodySmall: captionMedium,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  @override
  TextStyle get light => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w300,
        letterSpacing: 0,
      );

  @override
  TextStyle get regular => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  @override
  TextStyle get medium => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );

  @override
  TextStyle get semiBold => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      );

  @override
  TextStyle get bold => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      );
  @override
  TextStyle get contentMedium =>
      regular.copyWith(fontSize: 16, color: ColorName.whiteF1F1F1);
  @override
  TextStyle get contentLarge =>
      regular.copyWith(fontSize: 16, color: ColorName.grey8E8E8E);
  @override
  TextStyle get displayMedium =>
      regular.copyWith(fontSize: 16, color: ColorName.primary);
  @override
  TextStyle get displayLarge =>
      bold.copyWith(fontSize: 16, color: ColorName.primary);
  @override
  TextStyle get displaySmall =>
      regular.copyWith(fontSize: 14, color: ColorName.grey787878);

  @override
  TextStyle get headlineLarge => regular.copyWith(fontSize: 32);
  @override
  TextStyle get headlineMedium => regular.copyWith(
      fontSize: 11, color: ColorName.primary, fontWeight: FontWeight.bold);
  @override
  TextStyle get headlineSmall =>
      regular.copyWith(fontSize: 14, color: ColorName.whiteF1F1F1);
  @override
  TextStyle get contentSmall =>
      regular.copyWith(fontSize: 12, color: ColorName.whiteF1F1F1);

  @override
  TextStyle get headingSmall =>
      regular.copyWith(fontSize: 12, color: ColorName.primary);

  @override
  TextStyle get captionLarge =>
      bold.copyWith(fontSize: 16, color: ColorName.whiteF1F1F1);

  @override
  TextStyle get productTitle =>
      bold.copyWith(fontSize: 20, color: ColorName.primary);

  @override
  TextStyle get discount =>
      regular.copyWith(fontSize: 10, color: ColorName.primary);

  @override
  TextStyle get originalPrice => regular.copyWith(
      fontSize: 16,
      color: ColorName.grey8E8E8E,
      decoration: TextDecoration.lineThrough,
      decorationColor: ColorName.grey8E8E8E);

  @override
  TextStyle get titleSmall =>
      bold.copyWith(fontSize: 14, color: ColorName.greyBBBBBB);

  @override
  TextStyle get titleLarge =>
      bold.copyWith(fontSize: 14, color: ColorName.primary);
  @override
  TextStyle get titleMedium =>
      regular.copyWith(fontSize: 14, color: ColorName.black1E1E1E);
  @override
  TextStyle get bodySmall =>
      regular.copyWith(fontSize: 11, color: ColorName.primary);

  @override
  TextStyle get bodyMedium =>
      regular.copyWith(fontSize: 14, color: ColorName.grey8E8E8E);
  @override
  TextStyle get bodyLarge => bold.copyWith(color: ColorName.whiteF1F1F1);
  @override
  TextStyle get captionMedium =>
      regular.copyWith(fontSize: 14, color: ColorName.grey787878);

  @override
  TextStyle get labelLarge =>
      bold.copyWith(fontSize: 14, color: ColorName.white);
  @override
  TextStyle get labelMedium =>
      bold.copyWith(fontSize: 14, color: ColorName.primary);
  @override
  TextStyle get labelSmall =>
      regular.copyWith(fontSize: 10, color: ColorName.grey787878);
  @override
  TextStyle get caption =>
      regular.copyWith(fontSize: 14, color: ColorName.primary);
  @override
  TextStyle get captionSmall =>
      regular.copyWith(fontSize: 14, color: ColorName.whiteF1F1F1);
}
