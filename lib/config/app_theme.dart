import 'package:flutter/material.dart';
import './app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: kFontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kSeedColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kAppBorderRadius),
          ),
          padding: kButtonPadding,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kInputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
