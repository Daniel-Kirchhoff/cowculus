import 'package:flutter/material.dart';
import './app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: kFontFamily,
      brightness: Brightness.light,
      scaffoldBackgroundColor: kLightColorBackground,
      colorScheme: const ColorScheme.light(
        background: kLightColorBackground,
        surface: kLightColorSurface,
        primary: kLightColorPrimary,
        secondary: kLightColorAccent,
        onBackground: kLightColorFont1,
        onSurface: kLightColorFont1,
        onPrimary: kLightColorSurface,
        onSecondary: kLightColorFont1,
      ),
      textTheme: ThemeData.light()
          .textTheme
          .apply(fontFamily: kFontFamily, bodyColor: kLightColorFont1),
      appBarTheme: const AppBarTheme(
        backgroundColor: kLightColorSurface,
        foregroundColor: kLightColorFont1,
        elevation: 1,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kLightColorInputBackground,
        hintStyle: const TextStyle(color: kLightColorFont2),
        labelStyle: const TextStyle(color: kLightColorFont1),
        floatingLabelStyle: const TextStyle(color: kLightColorPrimary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: const BorderSide(color: kLightColorInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: const BorderSide(color: kLightColorPrimary, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: const BorderSide(color: kLightColorInputBorder),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kLightColorPrimary,
          foregroundColor: kLightColorSurface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kAppBorderRadius)),
          padding: kButtonPadding
              .add(const EdgeInsets.symmetric(vertical: kPaddingSmall / 2)),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: kFontFamily),
        ),
      ),
      checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
            fillColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? kLightColorPrimary
                    : kLightColorFont2),
            checkColor: MaterialStateProperty.all(kLightColorSurface),
          ),
      expansionTileTheme: ThemeData.light().expansionTileTheme.copyWith(
            backgroundColor: kLightColorSurface,
            collapsedBackgroundColor: kLightColorSurface,
            textColor: kLightColorFont1,
            iconColor: kLightColorPrimary,
            collapsedIconColor: kLightColorFont2,
          ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kLightColorFont2,
            fontFamily: kFontFamily),
        dataTextStyle:
            const TextStyle(color: kLightColorFont1, fontFamily: kFontFamily),
        decoration: BoxDecoration(
            border: Border.all(color: kLightColorBackground),
            borderRadius: BorderRadius.circular(kAppBorderRadius)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: kFontFamily,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kDarkColorBackground,
      colorScheme: const ColorScheme.dark(
        background: kDarkColorBackground,
        surface: kDarkColorSurface,
        primary: kDarkColorPrimary,
        secondary: kDarkColorAccent,
        onBackground: kDarkColorFont1,
        onSurface: kDarkColorFont1,
        onPrimary: kDarkColorSurface,
        onSecondary: kDarkColorFont1,
      ),
      textTheme: ThemeData.dark()
          .textTheme
          .apply(fontFamily: kFontFamily, bodyColor: kDarkColorFont1),
      appBarTheme: const AppBarTheme(
        backgroundColor: kDarkColorSurface,
        foregroundColor: kDarkColorFont1,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kDarkColorInputBackground,
        hintStyle: const TextStyle(color: kDarkColorFont2),
        labelStyle: const TextStyle(color: kDarkColorFont1),
        floatingLabelStyle: const TextStyle(color: kDarkColorPrimary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: const BorderSide(color: kDarkColorInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: const BorderSide(color: kDarkColorPrimary, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: const BorderSide(color: kDarkColorInputBorder),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorPrimary,
          foregroundColor: kDarkColorSurface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kAppBorderRadius)),
          padding: kButtonPadding
              .add(const EdgeInsets.symmetric(vertical: kPaddingSmall / 2)),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: kFontFamily),
        ),
      ),
      checkboxTheme: ThemeData.dark().checkboxTheme.copyWith(
            fillColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? kDarkColorPrimary
                    : kDarkColorFont2),
            checkColor: MaterialStateProperty.all(kDarkColorSurface),
          ),
      expansionTileTheme: ThemeData.dark().expansionTileTheme.copyWith(
            backgroundColor: kDarkColorSurface,
            collapsedBackgroundColor: kDarkColorSurface,
            textColor: kDarkColorFont1,
            iconColor: kDarkColorPrimary,
            collapsedIconColor: kDarkColorFont2,
          ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kDarkColorFont2,
            fontFamily: kFontFamily),
        dataTextStyle:
            const TextStyle(color: kDarkColorFont1, fontFamily: kFontFamily),
        decoration: BoxDecoration(
            border: Border.all(color: kDarkColorBackground),
            borderRadius: BorderRadius.circular(kAppBorderRadius)),
      ),
    );
  }
}
