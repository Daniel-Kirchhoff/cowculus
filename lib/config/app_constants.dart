import 'package:flutter/material.dart';

// === FARBEN ===
const Color kSeedColor = Colors.green;
final Color kInputFillColor = Colors.grey[100]!;
final Color kDataTableBorderColor = Colors.grey.shade300;
final Color kTotalRowHighlightColor = Colors.green.shade50;
final Color kHintTextColor = Colors.grey;

// === TEXT STILE & SCHRIFTARTEN ===
const String kFontFamily = 'Inter';
const double kHintTextFontSize = 12.0;

// === ABSTÄNDE & PADDING ===
const double kPaddingSmall = 8.0;
const double kPaddingMedium = 16.0;
const double kPaddingLarge = 24.0;
const EdgeInsets kButtonPadding =
    EdgeInsets.symmetric(horizontal: 20, vertical: 15);
const EdgeInsets kPanelPaddingBody =
    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
const EdgeInsets kScreenPaddingSmall = EdgeInsets.all(12.0);
const EdgeInsets kScreenPaddingLarge = EdgeInsets.all(24.0);

// === BORDER RADII ===
const double kAppBorderRadius = 8.0;

// === UI DIMENSIONEN / BREAKPOINTS ===
const double kSmallScreenBreakpoint = 600.0;
const double kDataTableColumnSpacing = 20.0;
const Size kElevatedButtonMinimumSize = Size(200, 50);
const double kIconSizeDefault = 24.0;
